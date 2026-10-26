#!/usr/bin/env bash
# Tests + living documentation for the .levers.yml Bash PreToolUse gate in settings.json.
#
# The gate denies a Bash command when a file viewer/filter (cat, less, head, tail, sed, awk,
# grep, rg, yq, bat, …) takes .levers.yml as an argument in the same pipeline segment.
# Any other command naming the file — git add/diff/log, trash, levers itself — passes.
# The companion Read gate (exact path match) has no regex worth testing.
#
# Runs the hook command straight out of settings.json, so there is no copy to drift.

set -euo pipefail
settings="$(dirname "$0")/../settings.json"
hook=$(jq -r '.hooks.PreToolUse[] | select(.matcher == "Bash") | .hooks[].command | select(contains("Use `levers get"))' "$settings")
[ -n "$hook" ] || { echo "levers gate not found in settings.json"; exit 1; }

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
BLOCK	cat .levers.yml
BLOCK	cat pkg/.levers.yml
BLOCK	head -20 .levers.yml
BLOCK	sed -n 1,10p .levers.yml
BLOCK	sed -i 's/a/b/' .levers.yml
BLOCK	grep coverage .levers.yml
BLOCK	yq .ci .levers.yml
BLOCK	cd x && cat .levers.yml
BLOCK	x=$(cat .levers.yml)
allow	levers get --at .
allow	levers get coverage --at pkg
allow	git add .levers.yml
allow	git diff -- .levers.yml
allow	git log --oneline -- .levers.yml
allow	trash .levers.yml
allow	ls -la .levers.yml
allow	cat .levers.yml.example
allow	cat README.md
CASES

if [ "$fails" -eq 0 ]; then
  printf '\nAll cases passed.\n'
else
  printf '\n%d case(s) FAILED.\n' "$fails"
  exit 1
fi
