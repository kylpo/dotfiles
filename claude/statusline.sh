#!/usr/bin/env bash
#
# Claude Code custom statusline.
# Reads the session JSON on stdin. Schema: https://code.claude.com/docs/en/statusline
#
# Renders two lines:
#   * Opus 5 - xhigh - 1M - qa-dot-md (main*)
#     280.1k tok (245.0k cached, 35.1k trip) - 5h 23% (2h10m) - 7d 41% (3d4h)
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
CYAN="${E}[36m"; GREEN="${E}[32m"; YELLOW="${E}[33m"; RED="${E}[31m"
BLUE="${E}[34m"; MAGENTA="${E}[35m"

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

# Green under 50%, yellow under 80%, red at or above.
pct_color() {
  if   [ "$1" -ge 80 ]; then printf '%s' "$RED"
  elif [ "$1" -ge 50 ]; then printf '%s' "$YELLOW"
  else                       printf '%s' "$GREEN"
  fi
}

# --- line 1: identity -------------------------------------------------------
line1="${BLUE}◆${R} ${BOLD}${model}${R}"
[ -n "$effort" ] && line1="${line1} ${DIM}·${R} ${CYAN}${effort}${R}"
[ -n "$win" ]    && line1="${line1} ${DIM}·${R} ${DIM}${win}${R}"

if [ -n "$dir" ]; then
  line1="${line1} ${DIM}·${R} $(basename "$dir")"
  if git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git -C "$dir" branch --show-current 2>/dev/null)
    [ -z "$branch" ] && branch=$(git -C "$dir" rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
      [ -n "$(git -C "$dir" status --porcelain 2>/dev/null | head -n1)" ] && branch="${branch}*"
      line1="${line1} ${MAGENTA}⎇ ${branch}${R}"
    fi
  fi
fi

# --- line 2: tokens + subscription usage ------------------------------------
sep=" ${DIM}·${R} "
if [ -n "$tok" ]; then
  line2="${BOLD}${tok} tok${R} ${DIM}(${R}${GREEN}${cached} cached${R}${DIM},${R} ${YELLOW}${trip} trip${R}${DIM})${R}"
else
  line2="${DIM}no API call yet${R}"
fi
if [ -n "$fh_pct" ]; then
  line2="${line2}${sep}${DIM}5h${R} $(pct_color "$fh_pct")${fh_pct}%${R}"
  [ -n "$fh_rst" ] && line2="${line2} ${DIM}(${fh_rst})${R}"
fi
if [ -n "$sd_pct" ]; then
  line2="${line2}${sep}${DIM}7d${R} $(pct_color "$sd_pct")${sd_pct}%${R}"
  [ -n "$sd_rst" ] && line2="${line2} ${DIM}(${sd_rst})${R}"
fi

printf '%s\n  %s\n' "$line1" "$line2"
