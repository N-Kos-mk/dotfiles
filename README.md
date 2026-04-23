# dotfiles

個人のdotfilesをGitとシンボリックリンクで管理するリポジトリ。

## 構成

```
dotfiles/
├── install.sh    # 新しい端末でのセットアップスクリプト
├── claude/       # Claude Code 設定
└── git/          # Git 設定（将来）
```

## 新しい端末へのセットアップ

```bash
git clone https://github.com/N-Kos-mk/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

## 追跡対象の追加方法

1. `~/dotfiles/<カテゴリ>/` に実体ファイルを置く
2. 元ファイルをシンボリックリンクに差し替える
3. `install.sh` にリンク作成コマンドを追記する
4. コミット＆プッシュ
