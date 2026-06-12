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
shell command (`cat`, `rm`, reading a giant generated file) when a project-specific tool
gives a better result — more context, an undo path, or a resolved/merged view. A deny with
a one-line reason is the cheapest way to steer it, every session, without relying on prompt
instructions it might not follow.

| Gate (tool → trigger) | Blocks | Steers to | Why |
| --- | --- | --- | --- |
| `Bash` → `rm` | deleting files with `rm` | `trash` | macOS Trash is recoverable; `rm` is not |
| `Bash` / `Read` → `cat`/`head`/`tail` of a file | reading a file to view it | the `Read` tool | `Read` gives line numbers, paging, and lets `Edit` target exact text |
| `Read` / `Bash` → `*.pbxproj` | opening the Xcode project file | the `pbxproj` CLI | the raw file is huge and burns context |
| `Bash` / `Read` → `.levers.yml` | reading the raw config file | `levers get` | the raw file skips inheritance resolution between root and package files |
| `Edit`/`Write` → `.blaster-plan.md`, `.blaster-metadata.json` | editing script-owned files | re-running the generating script | these files are derived; hand-edits get clobbered |
| `Write`/`Edit` → `SKILL.md` (first large change/session) | the first big write or edit | re-reading the style rules first | forces a style pass before authoring (see `skill-md-gate.sh`) |

Each gate is intentionally narrow — it denies one specific anti-pattern and allows
everything else.

### The cat/head/tail gate in detail

This is the gate worth understanding because the "block a file read but allow a pipe" line
is subtle. It denies a command only when **both** hold:

1. `cat`/`head`/`tail` appears as a **command-leading token** — at the start of the line,
   or right after `;`, `&&`, `||`. A single `|` is *not* a lead, so anything downstream of a
   pipe is never caught.
2. The command is **not** a transform or write — it has no heredoc (`<<`), no output
   redirect (`>`), and the leading `cat`/`head`/`tail` does not itself feed a pipe.

In short: **block reading a file to look at it; allow piping, slicing, and writing.**

| Command | Verdict | Reason |
| --- | --- | --- |
| `cat file.txt` | **block** | reading a file → use `Read` |
| `head -5 file.txt` | **block** | reading a slice → use `Read` with `offset`/`limit` |
| `tail -n 20 log.txt` | **block** | same |
| `git log \| head -20` | allow | `head` filters another command's output |
| `tail -n +2 data.csv \| sort` | allow | `tail` is a pipeline source (strips a header) |
| `cat a b > combined.txt` | allow | concatenating and writing, not viewing |
| `cat <<EOF` | allow | heredoc — this is a write |
| `cat file \| grep x` | allow | a pipe/transform (the model's call, even if `grep x file` is tidier) |

Trade-off: the last row means a "useless use of cat" slips through. That is deliberate — it
keeps the gate from flagging legitimate pipelines, which is the more common and more annoying
false positive.

## Testing the gates

Gates that are pure pattern-matching have tests in [`../hook-tests/`](../hook-tests/). They
mirror the exact regexes from `settings.json` and assert the verdict for a table of commands,
so they also serve as documentation of edge cases:

```
bash ../hook-tests/cat-head-tail-gate.test.sh
```

When you change a gate's regex in `settings.json`, update the matching test table and rerun.
