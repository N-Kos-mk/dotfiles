---
name: save-res
description: |
  Save a summary of the current conversation topic to claude-res/X_[title].md,
  where X is the next sequential number based on existing files.
  Trigger this skill when the user says things like "mdにまとめて", "mdに書いて",
  "まとめをmdに", "mdに保存して", "claude-resに保存して", or similar.
---

# save-res

Save a research or conversation summary to `claude-res/X_[title].md` in the current working directory.
Determine the next sequential number automatically and generate a concise Japanese title from the content.

## Trigger conditions

Activate when the user says (Japanese or English):
- 「mdにまとめて」「mdに書いて」「まとめをmdに」「mdに保存して」
- 「claude-resにまとめて」「claude-resに保存して」「claude-resに書いて」
- "save to md", "write to claude-res", "summarize to file"

Do NOT activate for general note-taking that the user clearly intends to keep in the chat only.

## Steps

1. **Determine the save directory**
   - Always use `<cwd>/claude-res/` where `<cwd>` is the current working directory of this session.
   - The directory already exists; do not create it unless it is truly missing.

2. **List existing files and compute the next number**
   Run:
   ```
   ls <cwd>/claude-res/ 2>/dev/null | sort
   ```
   - Files follow the pattern `N_title.md` (e.g., `1_視覚的評価基準まとめ.md`).
   - Find the highest N among existing files. The new file gets number `N+1`.
   - If no files exist, start at `1`.

3. **Generate a title**
   - Infer a short, descriptive Japanese title from the content being saved.
   - The title should be 10–20 characters, written in natural Japanese (kanji + kana OK).
   - Do NOT use slashes, colons, or other filesystem-unsafe characters in the title.
   - Format: noun phrase ending that clearly describes the topic (e.g., 「評価教示設計まとめ」「VAS-RRP実装メモ」).

4. **Write the file**
   - File path: `<cwd>/claude-res/X_<title>.md`
   - Content: a well-structured Markdown summary of the topic discussed.
     - Use `# Title` as H1 heading.
     - Use `## Section` headings to organize content.
     - Include key findings, decisions, references, and next steps where relevant.
     - Write in Japanese unless the content is inherently English (e.g., code, citations).
     - Aim for comprehensive but not verbose — include enough for a future AI to reconstruct context.

5. **Report to user**
   - Tell the user the exact file path created (e.g., `claude-res/3_評価手法まとめ.md`).
   - Give a one-sentence summary of what was written.

## Constraints

- Always save to `claude-res/` in the **current working directory** — never to a hardcoded absolute path.
- Never overwrite an existing file. If the file already exists (collision on number), increment until a free slot is found.
- Do not ask the user to confirm the title — generate it autonomously unless the topic is genuinely ambiguous, in which case ask once before writing.
- Do not save trivial or very short conversations (fewer than ~3 substantive exchanges). If the content seems too thin, tell the user and ask if they still want to save.
