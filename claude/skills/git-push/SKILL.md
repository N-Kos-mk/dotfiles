---
name: git-push
description: "Safely push the current branch to remote with pre-push verification and PR summary generation. Use this skill whenever the user invokes /git-push or asks to push commits to remote. Checks the target branch, shows commits to be pushed, blocks pushes to main/master, detects unauthorized merges, and invokes /git-pr-summary after a successful push. Do NOT trigger on general git questions or commit-only requests."
---

# Git Safe Push

Push the current branch to remote — but only after verifying everything looks right.
After a successful push, summarize what was pushed and invoke `/git-pr-summary` to generate a PR description.

## General Rules

- NEVER, UNDER ANY CIRCUMSTANCES, PUSH TO `main` OR `master`. IF THE CURRENT BRANCH IS `main` OR `master`, ABORT IMMEDIATELY AND TELL THE USER.
- Do not run `git merge` unless the user explicitly authorized it in the current conversation just before this push. If a merge is needed but not authorized, ask first.
- Always confirm before pushing — show the user what will be pushed and wait for approval.
- After a successful push, ask the user whether to create a PR before invoking `/git-pr-summary`.

## Workflow

### 1. Check the current branch

```bash
git branch --show-current
```

If the current branch is `main` or `master`: **stop immediately**. Tell the user in Japanese:
> 「現在のブランチは `main` です。このブランチには絶対にpushできません。feature/fix ブランチに切り替えてください。」

Do not proceed under any circumstances.

### 2. Show what will be pushed (pre-push confirmation)

Run:
```bash
git status
git log origin/$(git branch --show-current)..HEAD --oneline 2>/dev/null || git log --oneline -10
```

Display in Japanese:
- Current branch name
- Remote target (e.g. `origin/<branch>`)
- List of commits that will be pushed
- Whether the remote branch already exists or will be created

Then ask the user to confirm before proceeding. Do not push until the user says yes (or an equivalent affirmative).

### 3. Check for unauthorized merge operations

Look at the conversation context. If the push workflow involves running `git merge` (e.g., merging main into the feature branch to bring it up to date), check:

- Did the user explicitly say to merge in this conversation, just before invoking /git-push? → Proceed silently.
- Is a merge needed but the user gave no prior instruction about it? → **Ask first** in Japanese:
  > 「pushの前に `main` の最新をマージする必要がありますが、実行してよいですか？」

Wait for the user's answer. Do not merge without authorization.

### 4. Execute the push

```bash
git push origin $(git branch --show-current)
```

If the remote branch does not exist yet, use:
```bash
git push -u origin $(git branch --show-current)
```

If the push fails (e.g., rejected due to non-fast-forward), do NOT force push. Explain the situation to the user in Japanese and ask how to proceed.

### 5. Summarize and ask about PR

After a successful push, briefly summarize in Japanese:
- Which branch was pushed
- How many commits were pushed
- The commit subjects (one line each)

Then ask the user in Japanese:
> 「PRを作成しますか？」

Only invoke `/git-pr-summary` if the user says yes (or an equivalent affirmative). Do not auto-invoke it.

## Examples

**Blocked push to main:**
> 現在のブランチは `main` です。このブランチには絶対にpushできません。feature/fix ブランチに切り替えてください。

**Pre-push confirmation (Japanese):**
> 以下の内容をpushします。よろしいですか？
> - ブランチ: `feature/add-search` → `origin/feature/add-search`
> - コミット（3件）:
>   - `feat(search): ユーザー検索エンドポイントを追加`
>   - `test(search): 検索機能のユニットテストを追加`
>   - `docs: 検索APIのREADMEを更新`

**Unauthorized merge warning:**
> pushの前に `main` の最新をマージする必要がありますが、実行してよいですか？

**Post-push summary:**
> `feature/add-search` を origin にpushしました（3コミット）。
> PRを作成しますか？
