---
name: git-pr-summary
description: "Generate a Pull Request title and description in Japanese, then create the PR via GitHub CLI (`gh pr create`). Use this skill whenever the user invokes /git-pr-summary, says 「PRを作って」「プルリクを作成して」「PRの説明を生成して」, or when /git-push calls it after a successful push. Detects PR type (fix/feat/refactor/docs/chore), infers the correct base branch (develop by default; main if on develop branch), links related issues for fix-type PRs, and always confirms with the user before creating the PR."
---

# Git PR Summary

Generate a Pull Request title and body in Japanese, then create the PR via `gh pr create`.

This skill is designed for a branch workflow of: `main → develop → feature/fix branches`. The goal is to produce a clear, well-structured PR description that captures what changed and why — so reviewers understand the context without having to read every commit.

## General Rules

- Do NOT push — pushing is /git-push's job. This skill only creates the PR.
- Always show the generated title and body to the user and wait for their confirmation before running `gh pr create`.
- If `gh` is not authenticated, tell the user to run `gh auth login` first and stop.
- PR title and body are written in Japanese. Type labels in the checklist keep English in parentheses for searchability.

## Workflow

### 1. Identify current branch and base branch

```bash
git branch --show-current
git branch -a
```

Determine the base branch using this logic:
- If current branch is `develop` → base is `main`
- Otherwise → base is `develop` if it exists; fall back to `main` if not

### 2. Gather commit and diff information

```bash
git log origin/<base>..HEAD --oneline
git diff origin/<base>...HEAD --stat
```

This tells you what commits and files are included in this PR. For large diffs (>100 files), focus on the stat summary and key directories rather than reading every file.

### 3. Detect PR type

Look at the branch name prefix and commit message types together:

| Signal | PR type |
|--------|---------|
| `fix/`, `bugfix/`, `hotfix/` in branch name, or majority of commits are `fix:` | Bug Fix |
| `feat/`, `feature/`, `enhance/` in branch, or majority are `feat:` | Feature |
| `refactor/` or majority are `refactor:` | Refactoring |
| `docs/` or majority are `docs:` | Documentation |
| `chore/`, `ci/`, `perf/`, `test/`, or mixed | Other |
| Current branch is `develop` | Release (develop → main) |

### 4. Issue linking (fix-type PRs only)

For Bug Fix PRs:
1. Check the branch name for a number: `fix/123-description` → `#123`
2. Check commit messages for `closes #N`, `fixes #N`, `resolves #N`
3. If found, include `Closes #<N>` in the PR body
4. If not found, ask the user in Japanese: 「関連するissue番号はありますか？（なければスキップします）」

### 5. Generate PR title and body

**Title format:** `[Type] 日本語のタイトル`
- Types: `[Fix]`, `[Feat]`, `[Refactor]`, `[Docs]`, `[Chore]`, `[Release]`
- Keep it under 60 characters
- Describe the change, not the implementation (e.g. `[Feat] ユーザー検索機能を追加` not `[Feat] SearchServiceクラスを実装`)

**Body template:**

```markdown
## 概要
- <what this PR does, 1-3 bullets>

## 変更の種類
- [ ] バグ修正 (fix)
- [ ] 新機能 (feat)
- [ ] リファクタリング (refactor)
- [ ] ドキュメント (docs)
- [ ] その他 (chore/ci/perf/test)

## 変更内容
- <key changes derived from commit messages and diff, in Japanese>

## 関連issue
Closes #<N>
```

Mark the appropriate checkbox with `[x]`. Omit the `## 関連issue` section entirely if there is no issue to link.

### 6. Confirm with user

Display the generated title and body clearly, then ask in Japanese:
> 「上記の内容でPRを作成しますか？修正があれば教えてください。」

Wait for a yes/confirmation before proceeding. If the user wants changes, apply them and show the updated draft again.

### 7. Create the PR

```bash
gh pr create \
  --base <base-branch> \
  --title "<title>" \
  --body "$(cat <<'PRBODY'
<body>
PRBODY
)"
```

After success, report the PR URL in Japanese:
> 「PRを作成しました: <URL>」

## Examples

**Bug fix with issue:**
Branch: `fix/42-session-timeout`
Commits: `fix(auth): セッションタイムアウト時に401を返すよう修正`

Title: `[Fix] セッションタイムアウト処理を修正`

Body:
```markdown
## 概要
- ログイン時のセッションタイムアウト処理を修正し、期限切れ時に401エラーを返すよう変更

## 変更の種類
- [x] バグ修正 (fix)
- [ ] 新機能 (feat)
- [ ] リファクタリング (refactor)
- [ ] ドキュメント (docs)
- [ ] その他 (chore/ci/perf/test)

## 変更内容
- セッションタイムアウト検証ロジックを修正
- 期限切れトークンに対して401レスポンスを返すよう変更

## 関連issue
Closes #42
```

**Feature PR:**
Branch: `feat/user-search`
Commits: multiple `feat:` commits

Title: `[Feat] ユーザー検索機能を追加`

Body: same structure, `[x] 新機能 (feat)` checked, no issue section.

**Release PR (develop → main):**
Branch: `develop`
Title: `[Release] develop → main`

Body summarizes all notable changes merged into develop since the last release.
