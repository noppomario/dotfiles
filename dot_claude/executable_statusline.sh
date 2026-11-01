#!/usr/bin/env bash
# Claude Code status line: model, context usage, and subscription rate limits.
# Input: session JSON on stdin (https://code.claude.com/docs/en/statusline).

jq -r '
  def color(p):
    if p >= 95 then "\u001b[31m" elif p >= 80 then "\u001b[33m" else "" end;
  def pct(p): "\(color(p))\(p | floor)%\(if p >= 80 then "\u001b[0m" else "" end)";
  def window(name; w; fmt):
    if w.used_percentage == null then empty
    else "\(name) \(pct(w.used_percentage))"
      + (if w.resets_at then " (→\(w.resets_at | localtime | strftime(fmt)))" else "" end)
    end;
  [
    .model.display_name,
    (if .context_window.used_percentage != null then "ctx \(pct(.context_window.used_percentage))" else empty end),
    window("5h"; .rate_limits.five_hour // {}; "%H:%M"),
    window("7d"; .rate_limits.seven_day // {}; "%-m/%-d %H:%M")
  ] | join(" | ")
'
