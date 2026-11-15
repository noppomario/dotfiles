# Claude Code基本設定

## 言語とコミュニケーション

- **会話言語**: 常に日本語で応答すること
- **Planモードでの最終出力**: 日本語で記述すること
- **コード成果物**: 以下は英語で記述すること
  - コード内のコメント
  - ドキュメント（README.md、API仕様書など）
  - コミットメッセージ
  - 変数名・関数名（当然）
- **例外**: プロジェクト固有のCLAUDE.mdで指定がある場合はそちらを優先
- **例外**: Planモードの出力は日本語を利用する
- **例外**: 引き継ぎ用途など、コミット予定の無いドキュメントの生成には日本語を利用する

### 良い例・悪い例

```python
# 良い例: コメントは英語
def calculate_total(items):
    """Calculate the total price of items."""
    return sum(item.price for item in items)

# 悪い例: コメントが日本語
def calculate_total(items):
    """アイテムの合計金額を計算"""
    return sum(item.price for item in items)
```

## ドキュメント成果物の記載ルール

AI生成のドキュメントは冗長で情報密度が低くなりやすい。技術ドキュメントは保守対象であり、この傾向は致命的である:

- 冗長なドキュメント → 読まれない → 保守されない → 陳腐化して害になる

以下を徹底すること:

- 1文で済むことを3文で書かない
- 自明な前提や一般論を書かない（読み手はエンジニアである）
- 網羅性より正確性と簡潔さを優先する
- 更新コストを意識する: 詳細に書くほど保守負債になる
- 既存ドキュメントの更新は最小限の差分で行う: 全体の書き直しではなく、該当箇所のみ修正する

## MCPツール

以下が必要な場合は自動的にcontext7を使用すること:

- コード生成
- セットアップや設定手順
- ライブラリ/APIのドキュメント
- フレームワーク固有の実装詳細

明示的に指示されなくても、Context7 MCPツールでライブラリIDを解決し、最新のドキュメントを取得すること。

## CLIツール

- GitHubの操作が必要な場合は`gh`コマンドを使用すること
- npmパッケージの管理には`bun`コマンドを利用すること
- Pythonパッケージの管理には`uv`コマンドを利用すること（`pip`は使わない）
- npmパッケージのグローバルインストールには`mise use -g npm:<xxx>`コマンドを利用すること
- Pythonパッケージのグローバルインストールには`mise use -g pipx:<xxx>`コマンドを利用すること（内部でuvxを使用）
- Goツールのグローバルインストールには`mise use -g go:<module-path>`コマンドを利用すること

### GitHub PRのコメント取得

PRのコメントを確認する際は `gh pr view <number> --comments` を使用すること。

`gh pr view --json comments` は issue-level comments しか返さない。GitHub PRのコメントは3つのAPIに分散しているため、`--json comments` だけではレビューやインラインコメントを取りこぼす。

- `issues/{id}/comments` — PR本文下の一般コメント（`--json comments` はこれのみ）
- `pulls/{id}/reviews` — レビュー本体（approve/request changes等）
- `pulls/{id}/comments` — コード行へのインラインコメント

## settings.json 編集規則

`~/.claude/settings.json` を編集する際は以下を遵守すること。

### パス表記

- `Read`/`Edit` パターン: ホームディレクトリ配下は `~` を使用（例: `Read(~/.config/**)`）
- `Read`/`Edit` パターン: システムパスは `//` で絶対指定（例: `Read(//usr/bin/**)`）
- `Bash` パターン: チルダ非対応。絶対パスを使用すること

### 並び順

トップレベルキー: `language` → `permissions` → `hooks` → `enabledPlugins`

`permissions.allow` 内のカテゴリ順:

1. Web（WebFetch, WebSearch）
2. MCP
3. Bash — ビルド/開発ツール（bun, cargo等）
4. Bash — ファイル操作（ls, mkdir, tree等）
5. Bash — Git
6. Bash — GitHub CLI
7. Bash — システム管理
8. Skill
9. Read パス（`~` → `//` の順）

各カテゴリ内はアルファベット順。カテゴリ間は空行で区切る。

`enabledPlugins` 内もアルファベット順。

### 専用ツールとの重複禁止

Claude Codeの専用ツール（Glob, Grep, Read）で代替可能なBashコマンド（`find`, `grep`, `cat`等）について:

- `permissions.allow` に追加しないこと
- タスク実行時も専用ツールを優先すること（システムプロンプトの指示と同様）

## sudo禁止

`sudo`コマンドを実行してはならない。root権限が必要な操作はユーザーに実行コマンドを提示し、手動実行を依頼すること。

## 開発環境変更のdotfiles反映

このPCの環境はchezmoi（source: `~/.local/share/chezmoi`、リポジトリ: `noppomario/dotfiles`）とmiseで管理している。

ツールのインストール、`~/.config`等の設定変更、フォント追加、gsettings変更など環境に永続的な変更を加えた場合、作業の区切りで「dotfilesに反映するか」をユーザーに確認すること。

- 承認されたら設定ファイルは `chezmoi add`、インストール手順は `.chezmoiscripts/run_once_*` スクリプトとして追加する
- アプリが自動生成する状態ファイル（ウィンドウ位置、キャッシュ等）は管理対象にしない
- commit/pushはユーザーの指示があるまで行わない

## PC固有ノート

このPC固有の経緯・判断・ノウハウは `~/OneDrive/pc-notes/fedora/` に置く（git管理外、OneDrive同期）。索引: @~/OneDrive/pc-notes/fedora/README.md

- 環境に関わる作業の前に関連ノートを読む
- 以下を得たら該当ファイルに追記し、追記した旨を報告する: dotfilesとの意図的な差分の理由、採用・不採用の判断理由、試行錯誤の結果、このPCでのツールの癖
- 設定値そのもの（dotfilesで再現できる内容）は書かない。秘密情報は書かない。日付は絶対日付
- `README.md` は毎回読み込まれるため索引（1ファイル1行）に留め、内容は各ファイルに書く

## コーディングスタイル

- 簡潔で読みやすいコードを優先
- 言語固有の慣習とイディオムに従う
- 可能な場合は型ヒントを含める
