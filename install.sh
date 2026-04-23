#!/bin/bash
set -e
DOTFILES="$HOME/dotfiles"

mkdir -p "$HOME/.claude"

# ファイル: settings.json
ln -sf "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"

# ファイル: CLAUDE.md（存在する場合のみ）
[ -f "$DOTFILES/claude/CLAUDE.md" ] && \
  ln -sf "$DOTFILES/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

# ディレクトリ群（常にリンク）
for dir in skills agents hooks rules; do
  ln -sf "$DOTFILES/claude/$dir" "$HOME/.claude/$dir"
done

echo "Done. Symlinks created."
