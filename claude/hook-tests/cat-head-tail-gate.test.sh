#!/bin/bash
# Tests + living documentation for the cat/head/tail PreToolUse gate in settings.json.
#
# The gate denies a Bash command when BOTH hold:
#   1. LEAD matches  — cat/head/tail appears as a command-leading token
#      (start of line, or after ; && ||). A single | is NOT a lead, so
#      `... | head` is downstream-of-pipe and never a lead.
#   2. XFORM does NOT match — the command is not a transform/write. XFORM exempts:
#        <<            heredoc (cat <<EOF is a write, not a read)
#        >             any output redirect (cat a b > c concatenates)
#        c/h/t … |     a leading cat/head/tail that feeds a pipe within its own
#                      segment ([^|;]* up to the first |) — a pipeline SOURCE
#                      used to slice/transform, e.g. `tail -n +2 f | sort`.
#
# Net intent: BLOCK reading a file to view it; ALLOW piping/transforming/writing.
# Keep these patterns byte-identical to settings.json (unescaped shell form here).

LEAD='(^|;|&&|\|\|)[[:space:]]*(cat|head|tail)([[:space:]]|$)'
XFORM='(<<|>|(^|;|&&|\|\|)[[:space:]]*(cat|head|tail)[^|;]*\|)'

verdict() { # -> prints BLOCK or allow
  if printf '%s' "$1" | grep -Eq "$LEAD" && ! printf '%s' "$1" | grep -Eq "$XFORM"; then
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
done <<CASES
BLOCK	cat file.txt
BLOCK	head -5 file.txt
BLOCK	tail -n 20 log.txt
BLOCK	foo && cat bar
allow	git log | head -20
allow	grep x f | tail -5
allow	cat a b > combined.txt
allow	tail -n +2 data.csv | sort
allow	head -c 100 f | xxd
allow	cat <<EOF
allow	cat file | grep x
allow	cat > out.txt
allow	ps aux | grep something
allow	bat file.txt
CASES

if [ "$fails" -eq 0 ]; then
  printf '\nAll cases passed.\n'
else
  printf '\n%d case(s) FAILED.\n' "$fails"
  exit 1
fi
