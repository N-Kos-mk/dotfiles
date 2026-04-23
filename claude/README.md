# claude

Claude Code のグローバル設定。

## 追跡対象

| パス | シンボリックリンク元 | 読み込みタイミング |
|---|---|---|
| `settings.json` | `~/.claude/settings.json` | 起動時 |
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | 起動時（作成後追加） |
| `skills/` | `~/.claude/skills/` | 起動時（全件スキャン） |
| `agents/` | `~/.claude/agents/` | サブエージェントスポーン時 |
| `hooks/` | `~/.claude/hooks/` | settings.jsonから参照（手動） |
| `rules/` | `~/.claude/rules/` | CLAUDE.mdから参照（手動） |

## セットアップ

`../install.sh` を実行する。

## 運用メモ

- すべてシンボリックリンクのため、`~/.claude/` への変更は自動でここに反映される
- コミットは変更のたびに行う（`dsave` エイリアス推奨）
- プラグインは `settings.json` の `enabledPlugins` が管理するため `plugins/` 以下は追跡不要
