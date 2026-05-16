#!/usr/bin/env bash
# Modes: write | edit
# Reads hook JSON on stdin; emits hook JSON on stdout (or nothing).
set -euo pipefail

MODE="${1:?usage: skill-md-gate.sh write|edit}"
STYLE_FILE="${HOME}/.claude/hooks/skill-md-style.md"
STYLE=$(cat "$STYLE_FILE")
input=$(cat)

path=$(jq -r '.tool_input.file_path // empty' <<<"$input")
sid=$(jq -r '.session_id // empty' <<<"$input")
[[ "$path" =~ /SKILL\.md$ ]] || exit 0

case "$MODE" in
  edit)
    new=$(jq -r '.tool_input.new_string // empty' <<<"$input")
    [ "$(printf '%s' "$new" | wc -c)" -gt 400 ] || exit 0
    lead="SKILL.md style gate (first large edit per session). Reconsider the replacement."
    tail="Then call Edit again — it will pass."
    ;;
  write)
    lead="SKILL.md style gate (first write per session). Rewrite your draft from scratch."
    tail="Then call Write again — it will pass."
    ;;
  *)
    echo "usage: skill-md-gate.sh write|edit" >&2
    exit 1
    ;;
esac

marker="/tmp/claude-skill-gate-${sid}-$(printf '%s' "$path" | shasum | cut -c1-12)"
[ -e "$marker" ] && exit 0
: > "$marker"
reason="$lead $STYLE $tail"
jq -nc --arg r "$reason" \
  '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}'
