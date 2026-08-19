#!/usr/bin/env bash
#
# Claude Code custom statusline.
# Reads the session JSON on stdin. Schema: https://code.claude.com/docs/en/statusline
#
# Renders one left-aligned line:
#
#   qa-dot-md (main*) - Opus 5 - xhigh - 1M - 280.1k tok (245.0k cached, 35.1k trip) - 5h 24% (2h9m) - 7d 41% (3d3h)
#
# Location leads at full brightness; everything after it is dimmed, so the eye
# lands on the repo first. Only `cached` and `trip` keep a color, since those
# are the two numbers worth reacting to.
#
# Deliberately NOT right-aligned to the terminal edge. Claude Code re-runs this
# script on session start, new assistant messages, /compact, permission-mode
# changes, vim-mode toggles, and a refreshInterval timer -- but NOT on terminal
# resize. Any padding computed from COLUMNS therefore goes stale the moment the
# window is resized, and the over-long line gets truncated, taking the
# right-hand stats with it. A content-width line has nothing to go stale.
#
#   tok    = input-side tokens in the context window, i.e.
#            input_tokens + cache_creation_input_tokens + cache_read_input_tokens.
#            (Matches context_window.total_input_tokens. Output tokens excluded,
#            the same convention Claude Code uses for used_percentage.)
#   cached = cache_read_input_tokens. Served from cache, billed at ~0.1x.
#   trip   = tok - cached = input_tokens + cache_creation_input_tokens. The
#            full-price portion of the round trip that just completed. Note this
#            trip's cache_creation becomes next trip's cache_read, so on the next
#            call nearly all of `tok` reads from cache and only newly appended
#            content is full price. `trip` is therefore this trip's actual
#            uncached spend, used as the estimate for the next one.
#   5h/7d  = rate_limits.five_hour / .seven_day used_percentage, with time until
#            resets_at. Subscribers only; absent until the first API response.
#
# Permission mode (auto / plan / accept-edits) is deliberately NOT shown: it is
# not in the statusline payload. Claude Code renders this statusline in its own
# row above the built-in footer badges without replacing them, so its own
# permission-mode badge keeps displaying.

set -uo pipefail

input=$(cat)

E=$'\033'
BOLD="${E}[1m"; DIM="${E}[2m"; R="${E}[0m"
GREEN="${E}[32m"; YELLOW="${E}[33m"; MAGENTA="${E}[35m"
# Emphasis here is the *absence* of dim: a bare reset returns the segment to the
# terminal's own foreground at normal intensity, which stands out against the
# surrounding dim without hardcoding a color that would wash out on a light theme.

# Pull every JSON-derived field in one jq pass, joined by the ASCII unit
# separator (0x1f) so empty fields survive `read` -- a tab would collapse them,
# because tab is IFS whitespace.
fields=$(printf '%s' "$input" | jq -j '
  # Always one decimal for k/M so the three token figures stay column-aligned.
  def human:
    if . == null then ""
    elif . >= 1000000 then ((. / 100000) | floor) as $t | "\(($t / 10) | floor).\($t % 10)M"
    elif . >= 1000    then ((. / 100)    | floor) as $t | "\(($t / 10) | floor).\($t % 10)k"
    else "\(.)" end;

  def countdown:
    if . == null then "" else
      (((. - now) | floor)) as $d
      | if   $d <= 0     then "now"
        elif $d >= 86400 then "\(($d / 86400) | floor)d\((($d % 86400) / 3600) | floor)h"
        elif $d >= 3600  then "\(($d / 3600)  | floor)h\((($d % 3600)  / 60)   | floor)m"
        else                  "\(($d / 60)    | floor)m" end
    end;

  (.context_window.current_usage) as $u
  | (.context_window.context_window_size // 0) as $w
  | [ (.model.display_name // "?")
    , (.effort.level // "")
    , (if   $w >= 1000000 then "1M"
       elif $w > 0        then "\(($w / 1000) | floor)k"
       else                    "" end)
    , (if $u == null then "" else
         (($u.input_tokens // 0) + ($u.cache_creation_input_tokens // 0) + ($u.cache_read_input_tokens // 0)) | human
       end)
    , (if $u == null then "" else ($u.cache_read_input_tokens // 0) | human end)
    , (if $u == null then "" else
         (($u.input_tokens // 0) + ($u.cache_creation_input_tokens // 0)) | human
       end)
    , (if (.rate_limits.five_hour.used_percentage) == null then "" else
         (.rate_limits.five_hour.used_percentage | round | tostring) end)
    , (.rate_limits.five_hour.resets_at | countdown)
    , (if (.rate_limits.seven_day.used_percentage) == null then "" else
         (.rate_limits.seven_day.used_percentage | round | tostring) end)
    , (.rate_limits.seven_day.resets_at | countdown)
    , (.workspace.current_dir // .cwd // "")
    ] | join("\u001f")
')

IFS=$'\037' read -r model effort win tok cached trip fh_pct fh_rst sd_pct sd_rst dir <<< "$fields"

# --- location: the one bright segment ---------------------------------------
line=""
if [ -n "$dir" ]; then
  line="${BOLD}$(basename "$dir")${R}"
  if git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git -C "$dir" branch --show-current 2>/dev/null)
    [ -z "$branch" ] && branch=$(git -C "$dir" rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
      [ -n "$(git -C "$dir" status --porcelain 2>/dev/null | head -n1)" ] && branch="${branch}*"
      line="${line} ${MAGENTA}⎇ ${branch}${R}"
    fi
  fi
fi

# --- everything else, dimmed ------------------------------------------------
# Each colored value closes with a full reset, so the surrounding dim has to be
# re-opened after it rather than assumed to still be in effect.
dim_seg() {
  if [ -n "$line" ]; then line="${line}${DIM} · ${1}${R}"; else line="${DIM}${1}${R}"; fi
}

dim_seg "$model"
[ -n "$effort" ] && dim_seg "$effort"
[ -n "$win" ]    && dim_seg "$win"

if [ -n "$tok" ]; then
  dim_seg "${R}${tok} tok${DIM} (${R}${GREEN}${cached} cached${R}${DIM}, ${R}${YELLOW}${trip} trip${R}${DIM})"
else
  dim_seg "no API call yet"
fi

if [ -n "$fh_pct" ]; then
  seg="5h ${fh_pct}%"
  [ -n "$fh_rst" ] && seg="${seg} (${fh_rst})"
  dim_seg "$seg"
fi
if [ -n "$sd_pct" ]; then
  seg="7d ${R}${sd_pct}%${DIM}"
  [ -n "$sd_rst" ] && seg="${seg} (${sd_rst})"
  dim_seg "$seg"
fi

printf '%s\n' "$line"
