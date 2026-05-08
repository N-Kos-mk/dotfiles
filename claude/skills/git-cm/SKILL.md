---
name: git-cm
description: "Generate a Conventional Commits-style commit message and execute the commit automatically. Use this skill whenever the user invokes /git-cm or asks to commit staged changes. The type/scope format stays in English, but subject and body text are written in Japanese by default. If the user gave explicit code-change instructions in the conversation just before this commit, those instructions become the commit body as Japanese bullet points. Also verifies that the current branch is appropriate for the commit based on conversation context — warns the user if the branch looks wrong. Do NOT trigger on general git questions."
---

# Git Auto-Commit (Japanese message edition)

Generate a commit message following Conventional Commits format, then execute the commit immediately.

The format is always English (`type(scope): ...`), but the descriptive text — the subject and body — is written in Japanese by default. If the user explicitly asks for English (e.g. "英語で"), write in English instead.

## General Rules

- Type, scope label: always English
- Subject and body content: Japanese by default; English only on explicit user request
- Do not just print the commit command — execute it
- NEVER, UNDER ANY CIRCUMSTANCES, RUN `git push`. THIS SKILL DOES NOT PUSH. COMMITTING ONLY.

## Workflow

### 1. Check staged changes

```bash
git diff --cached --stat
```

If nothing is staged, stop here and tell the user to run `git add` first.

### 2. Analyze the diff

```bash
git diff --cached
```

For large diffs (>500 lines), read `--stat` first, then selectively read only the key changed files to keep context manageable. If you need history context, also run:

```bash
git log --oneline -5
```

### 3. Verify the current branch — and fix it if wrong

Run:
```bash
git branch --show-current
git branch -a
```

#### 3a. main / master への直接コミットは絶対禁止

現在のブランチが `main` または `master` の場合は**即座に停止**する。コミットせずに次のメッセージを返す:

> 「現在のブランチは `main` です。直接コミットはできません。適切なブランチに切り替えてください。」

**いかなる場合もこのルールを破らないこと。**

#### 3b. ブランチ名とコミット内容の整合性チェック

会話のコンテキスト・ブランチ名・diff の内容をあわせて判断する。以下の場合は**整合している**とみなして次のステップへ進む:

- `feat/xxx` ブランチで feature 系の変更をコミットしようとしている
- `fix/yyy` ブランチで バグ修正をコミットしようとしている
- `docs/zzz` ブランチでドキュメント変更をコミットしようとしている

以下の場合は**ズレあり**と判断する:

- `develop` で、明らかに独立ブランチにすべき規模の新機能（`feat` 系）をコミットしようとしている  
  ※ `chore`・`docs`・`fix`・`style` の小さな変更は `develop` 直接コミットとして許容する
- ブランチ名と diff の内容が明らかに無関係（例: `refactor-db` ブランチで認証ロジックを修正）

#### 3c. ズレがある場合のリカバリーフロー

ズレを検出した場合、**コミットは実行しない**。代わりに以下の手順を提示し、ユーザーに確認を取る。

**1. 状況を日本語で説明する**

- 現在のブランチ名
- なぜ不整合が疑われるか
- diff と会話から推定した適切なブランチ名（例: `feat/add-search`）

**2. 以下の回復手順をユーザーに提示して確認を取る**

> 「ステージ済みの変更は `<推奨ブランチ名>` にコミットすべきです。以下の手順で進めますか？
>
> 1. ステージ済みの変更を一時退避（stash）
> 2. 親ブランチ（`<parent-branch>`）に移動して fetch + pull で最新化
> 3. `<推奨ブランチ名>` を作成
> 4. stash を復元してコミット
>
> ブランチ名に問題があれば教えてください。」

**3. ユーザーが承認したら以下を実行する**

```bash
git stash
git checkout <分岐元ブランチ>
git fetch origin
git pull origin <分岐元ブランチ>
git checkout -b <推奨ブランチ名>
git stash pop
```

`git stash pop` が競合で失敗した場合は、ユーザーに競合ファイルを示して手動解決を促す。

その後、Step 4（コミット本文の確認）と Step 5（コミット実行）へ進む。

**4. ユーザーが断った場合**は停止し、手動での対応を促す。

#### 分岐元ブランチの決め方

「現在いるブランチ」ではなく「**作るべきブランチの種類**」で決まる。

| 作るべきブランチ | 分岐元（どこから切るか） |
|---|---|
| `feat/*`, `fix/*`, `docs/*`, `refactor/*` 等 | `develop`（存在する場合）、なければ `main` |
| `develop` そのものに戻す場合 | `main` |

> `main` / `master` は 3a でブロック済みのため分岐元にはならない。  
> 現在すでに分岐元ブランチにいる場合（例: `develop` にいて `feat/*` を切る）、`git checkout <分岐元>` は no-op になるが問題ない。

#### 推奨ブランチ名の付け方

- コミット種別に対応したプレフィックスを使う: `feat/`, `fix/`, `docs/`, `refactor/`, `chore/` 等
- diff と会話から内容を短く表現する（例: `feat/guild-permissions`, `fix/token-expiry`）
- 小文字・ハイフン区切り

### 4. Check conversation context for body content (for commit body)

Look back at the recent conversation. If the user gave **explicit code-change instructions** (e.g. "この関数を修正して", "〇〇を追加して", "XをYに変えて") that directly led to the staged changes, use those instructions as the commit body — formatted as concise Japanese bullet points.

If there were no clear prior instructions (e.g. the user just said "コミットして" or you can't identify instructions that match the changes), the body is optional. Skip it for small or self-evident diffs.

### 5. Generate and execute the commit

**Format:**
```
<type>[(<scope>)]: <Japanese subject>

<Japanese bullet-point body — only if applicable>
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`

**Subject rules:**
- Written in Japanese
- Imperative style (e.g. 〜を追加、〜を修正)
- No trailing period
- ≤50 characters

**Body rules (when used):**
- Each bullet starts with `- `
- Derived from the user's prior instructions, not from the diff itself
- Wrap at 72 characters per line

**Execute the commit directly:**

```bash
# Simple (no body)
git commit -m "fix(auth): トークンの有効期限チェックを修正"

# With body — use one -m flag per bullet point (do NOT use \n inside -m strings; it is treated as literal text in most shells)
git commit -m "feat(api): ユーザー検索エンドポイントを追加" \
  -m "- ユーザー名とメールアドレスを対象としたファジー検索を実装" \
  -m "- 検索結果は最大20件に制限"
```

After committing, briefly report the commit hash and subject in Japanese.

## Examples

**Simple — no prior instructions:**
```bash
git commit -m "fix(auth): トークンの有効期限チェックを修正"
```

**With body — user said "ログイン時のトークン検証ロジックを修正して、期限切れの場合は401を返すようにして":**
```bash
git commit -m "fix(auth): トークン検証ロジックを修正" \
  -m "- ログイン時のトークン検証ロジックを修正" \
  -m "- 期限切れトークンの場合に401エラーを返すよう変更"
```

**User requests English — "英語で":**
```bash
git commit -m "fix(auth): correct token expiration check"
```

**ブランチのズレを検出した場合（develop で feat 系変更をコミットしようとしている）:**

> 「現在のブランチは `develop` ですが、コミット内容は新機能の追加です。`feat/add-search` ブランチにコミットすべきです。以下の手順で進めますか？
>
> 1. ステージ済みの変更を一時退避（stash）
> 2. `develop` で fetch + pull（`feat/*` は `develop` から切るため）
> 3. `feat/add-search` を作成
> 4. stash を復元してコミット」

→ ユーザーが承認後（すでに `develop` にいるので checkout は no-op）:
```bash
git stash
git checkout develop   # すでに develop にいる場合は no-op
git fetch origin
git pull origin develop
git checkout -b feat/add-search
git stash pop
# → その後コミット実行
```
