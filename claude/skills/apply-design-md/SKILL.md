---
name: apply-design-md
description: Apply a site's DESIGN.md design-token specification (the Google Stitch DESIGN.md format) when generating or styling UI, so the output stays visually consistent with a specific brand's design language instead of using generic/default styling. Use this skill whenever the user asks to build UI "in the style of <brand>" (e.g. "Stripeっぽいデザインで作って", "Vercel風のランディングページ", "Notionみたいな見た目にして"), references a DESIGN.md file or a design-md/<site>/ path directly, or when a DESIGN.md file is sitting in the project root or a design-md/ subdirectory and the user asks for any UI/page/component work. Trigger even if the user doesn't say "DESIGN.md" explicitly — a bare brand name plus a styling request is enough.
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

This skill ships with a bundled reference library: a `design-md/` folder sitting
alongside this SKILL.md, inside the skill's own directory (sourced from the
VoltAgent/awesome-design-md collection). Each subfolder under it — e.g.
`design-md/stripe/`, `design-md/notion/` — holds that site's `DESIGN.md` (and
often a `README.md`). Resolve `design-md/...` paths in this file **relative to
this skill's own base directory**, not the current project's root — when this
skill is invoked, the tool context tells you that base directory; use it.

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
3. **Bundled `design-md/<site>/DESIGN.md`** — inside this skill's own
   directory, match the brand name the user mentioned against subdirectory
   names under `design-md/`. Be tolerant of naming variants (`stripe` vs
   `stripe.com`, case differences, hyphenation, `.ai`/`.app` suffixes like
   `mistral.ai`, `linear.app`).

If none of these confidently resolve to a file, **do not guess at colors, fonts, or
other tokens**. Ask the user which design system to use, or where the file lives.
Inventing plausible-looking tokens defeats the entire purpose of the format — the
value of DESIGN.md is that the tokens are real, extracted values, not vibes.

If a matched site's folder also contains `preview.html` / `preview-dark.html`,
mention that the user can open it as a visual reference — but treat the `DESIGN.md`
text itself as the source of truth for actual token values, since the preview is
just a rendering of it.

## Applying the tokens

Read the whole file before writing any UI code. It follows this 9-section shape:

1. Visual Theme & Atmosphere
2. Color Palette & Roles
3. Typography Rules
4. Component Stylings
5. Layout Principles
6. Depth & Elevation
7. Do's and Don'ts
8. Responsive Behavior
9. Agent Prompt Guide

Use the palette, type scale, component styles, spacing/layout rules, and
shadow/elevation system from the file as the actual constraints for what you
generate — not inspiration to loosely riff on. If the file defines a coral CTA at
a specific hex and a serif display face for headings, that's what the button and
headings should use, not an approximation. Introducing colors, fonts, or spacing
values that aren't in the file quietly defeats the point of having the file at all.

Treat section 7 (Do's and Don'ts) as binding constraints on the output, not
optional style notes. If it says "never use rounded corners on primary CTAs" or
similar, honor that even if it conflicts with a more generic instinct.

Apply section 8 (Responsive Behavior) when the requested UI needs to respond to
viewport size — breakpoints, touch target sizing, collapsing strategy, etc.

## Output

Deliver whatever the user actually asked for — a component, a page, a full
mockup — styled per the DESIGN.md. This skill produces working UI code, not a
report about the design system. After generating it, add one short line noting
which DESIGN.md was used (path is enough), so the user can confirm the right one
was picked up before investing more time in that direction.
