# Authoring hooks

A PreToolUse hook runs on every tool call its matcher selects, and matchers match the tool
name only — never a filename or argument. Most invocations are non-targets. Make the no-op path
the cheapest path in the file; process spawns (`bash`, `jq`, `cat`, `grep`) dominate cost.

1. Read stdin once (`input=$(cat)`); feed every `jq` with `<<<"$input"`.

2. Extract only the field the early exit needs, test it, and `exit 0` before any further work:

   ```bash
   path=$(jq -r '.tool_input.file_path // empty' <<<"$input")
   [[ "$path" =~ /TARGET$ ]] || exit 0
   ```

3. When several fields are needed past the early exit, pull them in one `jq` call via `@sh` +
   `eval`, never one `jq` per field. Pre-init the vars so a malformed payload leaves them empty
   under `set -u`:

   ```bash
   agent_type="" tool="" path="" cmd=""
   eval "$(jq -r '@sh "agent_type=\(.agent_type // "") tool=\(.tool_name // "") path=\(.tool_input.file_path // "") cmd=\(.tool_input.command // "")"' <<<"$input")"
   ```

4. Defer file reads and extra subprocesses to the branch that uses them — read a message file
   just before printing the deny JSON, not at the top.

5. Inline a one-field, one-regex gate in `../settings.json`. Write a script only for logic too
   large to inline; a script adds a `bash` spawn per call.

6. In a telemetry or notification hook, use one pipeline and no `jq` unless you branch on a
   field. Background anything that blocks (`afplay … &`).

7. Start every script with `#!/usr/bin/env bash` then `set -euo pipefail`.

8. When you change a gate's regex, update its table-driven test in `../hook-tests/` and rerun it:
   run `bash ../hook-tests/cat-head-tail-gate.test.sh`.
