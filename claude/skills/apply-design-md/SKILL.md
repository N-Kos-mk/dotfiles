---
name: apply-design-md
description: Apply a site's DESIGN.md design-token specification (the Google Stitch DESIGN.md format) when generating or styling UI, so the output stays visually consistent with a specific brand's design language instead of using generic/default styling. Use this skill whenever the user asks to build UI "in the style of <brand>" (e.g. "Stripeっぽいデザインで作って", "Vercel風のランディングページ", "Notionみたいな見た目にして"), references a DESIGN.md file or a design-md/<site>/ or design-md-additional/<site>/ path directly, or when a DESIGN.md file is sitting in the project root or a design-md/ subdirectory and the user asks for any UI/page/component work. This also covers the user's own hand-written design systems bundled under design-md-additional/ (e.g. "nkos.dev風で", "自分のサイトのデザインで作って"). Trigger even if the user doesn't say "DESIGN.md" explicitly — a bare brand or site name plus a styling request is enough.
---

# Apply DESIGN.md

## What this is

DESIGN.md is a plain-text design-token specification format (introduced by Google
Stitch: https://stitch.withgoogle.com/docs/design-md/overview/). Each file captures
one site's design system — color palette, typography, component styling, layout,
elevation, and explicit do's/don'ts — in a form an AI agent can read directly and
apply, without Figma exports or JSON schemas.

This skill's job is to **find the right DESIGN.md and apply its tokens faithfully**
when generating UI, rather than falling back on generic styling choices.

This skill ships with two bundled reference libraries, both sitting alongside this
SKILL.md inside the skill's own directory:

- **`design-md/`** — the upstream collection (sourced from
  VoltAgent/awesome-design-md). Each subfolder — e.g. `design-md/stripe/`,
  `design-md/notion/` — holds that site's `DESIGN.md` (and often a `README.md`).
- **`design-md-additional/`** — the user's own additions: design systems not
  present upstream, typically hand-written for their own sites or projects (e.g.
  `design-md-additional/nkos.dev/`). Same folder-per-site layout, same DESIGN.md
  format. This folder is authoritative for anything it covers.

Resolve `design-md/...` and `design-md-additional/...` paths in this file
**relative to this skill's own base directory**, not the current project's root —
when this skill is invoked, the tool context tells you that base directory; use it.
Don't assume either folder's contents from memory: list them and match against
what's actually there.

A DESIGN.md can also exist outside the bundle: a user may drop one directly into
their project root (e.g. a one-off brand not in the bundled collection, or a
custom one they wrote themselves). Check for that case too.

## Locating the right file

Check in this order, and stop at the first match:

1. **Explicit path or brand given by the user** — if they name a file or a
   folder directly, use that.
2. **Project root `DESIGN.md`** — if one exists in the current project (not
   this skill's bundle) and the user hasn't named a different brand, this is
   almost certainly the one they mean — it signals a project-specific design
   system that overrides the bundled library.
3. **Bundled `design-md-additional/<site>/DESIGN.md`** — the user's own
   additions. Check this folder **before** `design-md/`: if a name matches in
   both, the additional entry wins, since it's the one the user deliberately
   wrote or curated.
4. **Bundled `design-md/<site>/DESIGN.md`** — the upstream collection.

For steps 3 and 4, match the brand or site name the user mentioned against the
subdirectory names, and be tolerant of naming variants (`stripe` vs `stripe.com`,
case differences, hyphenation, `.dev`/`.ai`/`.app` suffixes like `nkos.dev`,
`mistral.ai`, `linear.app`).

If none of these confidently resolve to a file, **do not guess at colors, fonts, or
other tokens**. Ask the user which design system to use, or where the file lives.
Inventing plausible-looking tokens defeats the entire purpose of the format — the
value of DESIGN.md is that the tokens are real, extracted values, not vibes.

A file may scope itself to part of a site rather than the whole thing — the
frontmatter `description` is where that's declared (e.g. "this file covers the top
page only; other pages use a different system"). Honor the stated scope: don't
apply a page-scoped token set to a surface it excludes.

If a matched site's folder also contains `preview.html` / `preview-dark.html`,
mention that the user can open it as a visual reference — but treat the `DESIGN.md`
text itself as the source of truth for actual token values, since the preview is
just a rendering of it.

## Applying the tokens

Read the whole file before writing any UI code. Every DESIGN.md opens with a YAML
frontmatter block holding the machine-readable tokens (`colors:`, `typography:`,
`rounded:`, `spacing:`, `components:`), followed by prose sections that explain how
to use them. The prose comes in two layouts:

- **Section-name form** (the majority of the bundle, and what
  `design-md-additional/` uses): `Overview`, `Colors`, `Typography`, `Layout`,
  `Elevation & Depth`, `Shapes`, `Components`, `Do's and Don'ts`,
  `Responsive Behavior`, `Iteration Guide`, `Known Gaps`.
- **Numbered form** (a minority of upstream entries): `1. Visual Theme &
  Atmosphere`, `2. Color Palette & Roles`, `3. Typography Rules`,
  `4. Component Stylings`, `5. Layout Principles`, `6. Depth & Elevation`,
  `7. Do's and Don'ts`, `8. Responsive Behavior`, `9. Agent Prompt Guide`.

Individual files may add a section beyond either list when the design demands it —
for example `Motion`, where the animation timing is itself part of the design
signature. Treat those extra sections as binding too, not as commentary.

Values in the frontmatter reference each other with `{colors.x}` /
`{typography.y}` / `{spacing.z}` placeholders, and the prose uses the same
notation. Resolve those references rather than copying the placeholder text into
your output.

Use the palette, type scale, component styles, spacing/layout rules, and
shadow/elevation system from the file as the actual constraints for what you
generate — not inspiration to loosely riff on. If the file defines a coral CTA at
a specific hex and a serif display face for headings, that's what the button and
headings should use, not an approximation. Introducing colors, fonts, or spacing
values that aren't in the file quietly defeats the point of having the file at all.

Treat **Do's and Don'ts** as binding constraints on the output, not optional style
notes. If it says "never use rounded corners on primary CTAs" or similar, honor
that even if it conflicts with a more generic instinct.

Apply **Responsive Behavior** when the requested UI needs to respond to viewport
size — breakpoints, touch target sizing, collapsing strategy, etc.

**Known Gaps**, where present, marks what the file deliberately does not define. If
the requested UI needs something listed there, say so rather than filling the gap
with invented tokens.

## Output

Deliver whatever the user actually asked for — a component, a page, a full
mockup — styled per the DESIGN.md. This skill produces working UI code, not a
report about the design system. After generating it, add one short line noting
which DESIGN.md was used (path is enough), so the user can confirm the right one
was picked up before investing more time in that direction.
