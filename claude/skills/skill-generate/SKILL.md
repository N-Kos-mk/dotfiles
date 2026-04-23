---
name: skill-generate
description: Guided skill creation assistant that helps users design and build new Claude Code skills. Use this skill whenever a user wants to create a new skill, add a slash command, automate a repeated workflow into a reusable skill, or says something like "スキルを作って" (make me a skill), "新しいスキルが欲しい" (I want a new skill), "コマンドを追加したい" (I want to add a command), or "これをスキルにして" (turn this into a skill). Always invoke this skill before starting any skill creation work — it handles requirement gathering, conflict checking, and delegation to skill-creator.
---

# Skill Generate

A guided assistant for creating new Claude Code skills. This skill ensures that every new skill is well-designed, clearly scoped, and follows best practices before any code is written.

## Core philosophy

The goal here is to create skills that are genuinely useful and maintainable — not to churn out skill files quickly. Before writing anything, understand what the user actually needs. A skill that does one thing well is far more valuable than one that tries to do everything.

## Language policy

- **User conversation**: Always in Japanese (日本語)
- **Skill file content**: Always in English, written to be clear and precise for an AI reader

## File organization

When saving a newly created skill, use the appropriate location based on scope:

- **User scope** (applies across all projects on this machine): `~/.claude/skills/<name>/SKILL.md`
- **Project scope** (applies only within a specific project): `<project-root>/.claude/skills/<name>/SKILL.md`

Default to user scope unless the user explicitly requests project scope. Always confirm the scope with the user before handing off to skill-creator.

The `.claude/commands/` directory is a legacy format. The `skills/<name>/SKILL.md` structure is recommended for all new skills. Both are loaded identically, but the `skills/` format is more scalable and better supports bundled resources (scripts, references, assets).

## Workflow

Follow these steps in order. Use `AskUserQuestion` whenever you need the user to make a choice or clarify something — don't guess.

### Step 1: Understand the intent

Start by understanding what the user wants the skill to do. Extract as much as you can from the conversation history before asking questions. Then ask about anything that's still unclear:

- What problem does this skill solve?
- What should the user type (or say) to trigger it?
- What does success look like — what output or outcome does the user expect?
- Are there edge cases or exceptions to handle?

If the request is vague, ask a focused follow-up question using `AskUserQuestion` before proceeding.

### Step 2: Check for existing skills

Before designing anything new, check whether an existing skill already covers this use case. Look at skills in `~/.claude/skills/` and the installed plugin cache. If an existing skill handles the need — even partially — surface that to the user and ask whether they want to use the existing skill, extend it, or proceed with creating a new one.

Common overlap areas:
- `skill-creator`: Creating or improving skills
- `frontend-design`: Building web UIs
- `claude-code-setup`: Claude Code automation setup
- `update-config`: Claude Code settings

### Step 3: Apply the single responsibility principle

Each skill should do one thing well. If the request involves multiple distinct capabilities (e.g., "analyze data AND generate a report AND send an email"), raise this with the user and propose splitting into separate skills. Use `AskUserQuestion` to confirm before proceeding.

Signs that a skill should be split:
- The skill would need to branch into very different workflows
- The trigger phrase covers unrelated scenarios
- Two different users might want only one part

### Step 4: Design the skill

Work out the following before writing anything:

**Name**: Concise, verb-based, lowercase with hyphens. The verb should capture the primary action.
- Good: `analyze-logs`, `convert-csv`, `review-pr`
- Avoid: `log_analyzer`, `csv-to-json-converter`, `my-custom-skill`

**Scope**: Where the skill will be saved. Use `AskUserQuestion` to confirm.
- **User scope** (default): `~/.claude/skills/<name>/` — applies across all projects on this machine
- **Project scope**: `<project-root>/.claude/skills/<name>/` — applies only within the current project

**Trigger conditions**: What phrases or situations should activate this skill? Be specific. Include both English and Japanese trigger examples where the user's primary language is Japanese.

**Input/output**: What does the skill receive? What does it produce?

**Key behaviors**: The 3-5 most important things the skill must do (or avoid doing).

Share the design with the user before writing. Use `AskUserQuestion` if there's a meaningful design decision that affects the outcome.

### Step 5: Hand off to skill-creator

Once the design is confirmed, invoke the `skill-creator` skill to write and iterate on the skill. Pass the complete specification, including the save path confirmed in the previous step:

```
Create a new skill called "<name>" and save it to `~/.claude/skills/<name>/SKILL.md`.
[Project scope alternative: `<project-root>/.claude/skills/<name>/SKILL.md`]

## Purpose
<one paragraph description>

## Key behaviors
<bullet list of behaviors>

## Trigger conditions
<bullet list of trigger phrases and contexts>

## Workflow
<numbered steps the skill should follow>

## Output format
<what the skill should produce>

## Language policy
<if relevant>
```

Always use the full absolute path confirmed in Step 4. Never let skill-creator decide the save location on its own.

Let skill-creator handle the drafting, testing, and iteration loop. Your role is requirement gathering and design — skill-creator's role is execution.

## Quick reference: AskUserQuestion usage

Use `AskUserQuestion` (not inline text questions) whenever:
- The user needs to choose between options (e.g., split into 2 skills vs. keep as 1)
- A requirement is ambiguous and both interpretations are plausible
- You'd recommend an existing skill but want to confirm before abandoning the new-skill path
- A design decision significantly affects scope or complexity

Don't use it for questions you can reasonably infer from context.

## Example interaction flow

1. User: "スキルを作りたい — Gitコミットのレビューをしてくれるやつ"
2. skill-generate: (checks existing skills in `~/.claude/skills/` and plugin cache, finds no direct match)
3. skill-generate: (asks via AskUserQuestion) "どんなことをレビューしますか？コミットメッセージの品質、コードの変更内容、両方？"
4. User: "コミットメッセージだけでいい"
5. skill-generate: (asks via AskUserQuestion) "このスキルはすべてのプロジェクトで使いますか（ユーザースコープ: `~/.claude/skills/`）、それとも今のプロジェクト専用にしますか（プロジェクトスコープ）？"
6. User: "全プロジェクトで使いたい"
7. skill-generate: (confirms design) "名前は `review-commit`、保存先は `~/.claude/skills/review-commit/SKILL.md` で skill-creator に渡します。"
8. skill-generate: (hands off to skill-creator with full specification including explicit save path)
