#!/usr/bin/env bash
# Tests + living documentation for the rm PreToolUse gate in settings.json.
#
# The gate denies a Bash command when `rm` sits in command position:
#   - start of a line, or right after ; & | ( `   (covers &&, ||, $( … ))
#   - right after sudo, xargs or -exec, with any flags between (`xargs -0 rm`)
# `rm` as an argument or inside text is never caught, so `git rm`, `docker rm`,
# `grep rm f` and a commit message mentioning rm all pass.
#
# Runs the hook command straight out of settings.json, so there is no copy to drift.

set -euo pipefail
settings="$(dirname "$0")/../settings.json"
hook=$(jq -r '.hooks.PreToolUse[] | select(.matcher == "Bash") | .hooks[].command | select(contains("Use `trash` instead of `rm`"))' "$settings")
[ -n "$hook" ] || { echo "rm gate not found in settings.json"; exit 1; }

verdict() { # -> prints BLOCK or allow
  if [ -n "$(jq -n --arg c "$1" '{tool_input:{command:$c}}' | bash -c "$hook")" ]; then
    printf 'BLOCK'
  else
    printf 'allow'
  fi
}

# expected<TAB>command  — edit this table to document new cases.
fails=0
while IFS=$'\t' read -r want cmd; do
  [ -z "$want" ] && continue
  got=$(verdict "$cmd")
  if [ "$got" = "$want" ]; then
    printf '  ok   %-6s %s\n' "$got" "$cmd"
  else
    printf 'FAIL  want=%s got=%s  %s\n' "$want" "$got" "$cmd"
    fails=$((fails + 1))
  fi
done <<'CASES'
BLOCK	rm file.txt
BLOCK	rm -rf build
BLOCK	cd x && rm y
BLOCK	foo; rm y
BLOCK	foo || rm y
BLOCK	ls | rm
BLOCK	echo $(rm y)
BLOCK	sudo rm y
BLOCK	find . -name '*.o' -exec rm {} \;
BLOCK	ls | xargs -0 rm
allow	git rm foo
allow	cd x && git rm --cached y
allow	docker rm abc
allow	bun rm zod
allow	grep -n rm src/x.ts
allow	ls | grep -v rm
allow	git commit -m "drop the rm step"
allow	trash file.txt
allow	rmdir empty
allow	npm run format
CASES

if [ "$fails" -eq 0 ]; then
  printf '\nAll cases passed.\n'
else
  printf '\n%d case(s) FAILED.\n' "$fails"
  exit 1
fi
