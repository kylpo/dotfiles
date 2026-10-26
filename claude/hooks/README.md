# Claude Code hooks

Hooks are shell commands Claude Code runs at defined points in its lifecycle. They are
configured under the `"hooks"` key in [`../settings.json`](../settings.json); a few are
broken out into standalone scripts in this directory. A hook receives a JSON event on
stdin and may print JSON on stdout to influence what happens next.

The hooks here fall into two groups.

## 1. Telemetry hooks (observe only)

Almost every lifecycle event (`SessionStart`, `Stop`, `PreToolUse`, `Notification`,
`SubagentStop`, …) pipes its JSON payload to a Unix socket:

```
printf '{"ppid":%s,"event":%s}\n' "$PPID" "$(cat)" | nc -U .../MAIFocus/Data/server.sock
```

These feed an external desktop app (MAIFocus) so it can show what the agent is doing.
They never block or change a tool call — they only watch.

The sound helpers `done-alert.sh` / `input-alert.sh` are the same idea: play a chime when
the agent finishes or needs input.

## 2. Policy gates (allow / deny tool calls)

These run on `PreToolUse` and can **deny** a tool call, returning a short message that tells
the agent what to do instead. The agent then retries with the suggested approach.

Why gates instead of just trusting the model: the agent will reach for a familiar
shell command (`rm`, reading a giant generated file) when a project-specific tool
gives a better result — more context, an undo path, or a resolved/merged view. A deny with
a one-line reason is the cheapest way to steer it, every session, without relying on prompt
instructions it might not follow.

| Gate (tool → trigger) | Blocks | Steers to | Why |
| --- | --- | --- | --- |
| `Bash` → `rm` in command position | deleting files with `rm` | `trash` | macOS Trash is recoverable; `rm` is not |
| `Read` / `Bash` → `*.pbxproj` | opening the Xcode project file | the `pbxproj` CLI | the raw file is huge and burns context |
| `Read` / `Bash` → `.levers.yml` passed to a viewer (`cat`, `sed`, `grep`, `yq`, …) | reading the raw config file | `levers get` | the raw file skips inheritance resolution between root and package files |
| `Edit`/`Write` → `.blaster-plan.md`, `.blaster-metadata.json` | editing script-owned files | re-running the generating script | these files are derived; hand-edits get clobbered |
| `Write`/`Edit` → `SKILL.md` (first large change/session) | the first big write or edit | re-reading the style rules first | forces a style pass before authoring (see `skill-md-gate.sh`) |

Each gate is intentionally narrow — it denies one specific anti-pattern and allows
everything else.

### The rm gate in detail

The gate must catch `rm` the command without catching `rm` the word. It denies only when
`rm` sits in **command position**: at the start of a line, right after `;`, `&`, `|`, `(` or
a backtick (which covers `&&`, `||` and `$( … )`), or right after `sudo`, `xargs` or `-exec`
with any flags between.

| Command | Verdict | Reason |
| --- | --- | --- |
| `rm -rf build` | **block** | deleting → use `trash` |
| `cd x && rm y` | **block** | `rm` leads a chained command |
| `ls \| xargs -0 rm` | **block** | `rm` run by `xargs` |
| `git rm foo` | allow | `rm` is a git subcommand |
| `docker rm abc` | allow | another tool's subcommand |
| `grep -n rm src/x.ts` | allow | `rm` is a search term |
| `git commit -m "drop the rm step"` | allow | `rm` is text |

Trade-off: `rm` after `;` or `|` inside a quoted string (`echo "a; rm b"`) is still denied.
Telling quotes apart needs a shell parser, and the miss is rare.

## Testing the gates

Gates that are pure pattern-matching have tests in [`../hook-tests/`](../hook-tests/). Each
test pulls the hook command out of `settings.json` and runs it against a table of commands,
so the table documents the edge cases and cannot drift from the live regex:

```
bash ../hook-tests/rm-gate.test.sh
bash ../hook-tests/levers-gate.test.sh
```

When you change a gate's regex in `settings.json`, update the matching test table and rerun.
