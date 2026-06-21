#!/usr/bin/env bash
# Modes: write | edit
# Reads hook JSON on stdin; emits hook JSON on stdout (or nothing).
set -euo pipefail

MODE="${1:?usage: skill-md-gate.sh write|edit}"
input=$(cat)

# Cheap early exit: only SKILL.md files are gated. Extract just the path first
# (one jq) so the common case — any other file — costs a single jq and nothing else.
path=$(jq -r '.tool_input.file_path // empty' <<<"$input")
[[ "$path" =~ /SKILL\.md$ ]] || exit 0

# SKILL.md only past here (rare): pull the remaining fields in one jq pass, @sh-
# quoted so a large/multi-line new_string is assigned safely.
sid="" new=""
eval "$(jq -r '@sh "sid=\(.session_id // "") new=\(.tool_input.new_string // "")"' <<<"$input")"

case "$MODE" in
  edit)
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
STYLE=$(cat "${HOME}/.claude/hooks/skill-md-style.md")   # only read when actually denying
reason="$lead $STYLE $tail"
jq -nc --arg r "$reason" \
  '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}'
