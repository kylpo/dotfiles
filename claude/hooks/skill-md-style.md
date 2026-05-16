Audience: Agents. Not humans. Apply when authoring or editing any SKILL.md.

- Terse imperatives. Strip words that do not change Agent behavior.
- No hedges ("maybe", "consider", "you might"). No optionality unless the branch condition is explicit and checkable.
- No preamble, transitions, motivational framing, recaps, or teaching examples.
- Steps form a contiguous procedure; each step assumes the prior ran.
- Preserve every load-bearing instruction. Relocate human-valuable prose to README.md; do not delete.
- Headings only when a step references a prior section by name, or when another file links to a section.
- Code fences only when the Agent must emit an exact string.
- One term per concept across the skill.
- No time-sensitive phrasing. For deprecation, add a `Legacy patterns` section instead of dating prose.
- Mechanical, deterministic steps (no LLM judgment required) belong in versioned scripts at <skill>/*.sh; promote to ~/.claude/scripts/ only when reused across ≥2 skills.
- Each script reference reads "run …" (execute) or "see … for …" (reference).
