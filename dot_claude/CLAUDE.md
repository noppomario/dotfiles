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

## Markdown記述ルール

Claude Codeが生成する全てのmarkdown（プランファイル、ドキュメント等）は、**markdownlintの全ルール**に準拠すること。

### 遵守すべきルール

全てのmarkdownlintルール（MD001-MD050等）に従うこと。

主要なルール（例）:

- **MD001**: 見出しレベルは段階的に増加
- **MD013**: 無効（エディタで折り返されるため）
- **MD022**: 見出しの前後に空行
- **MD029**: 順序付きリストは1,2,3...形式
- **MD032**: リストの前後に空行
- **MD036**: 強調を見出しの代わりに使わない
- **MD040**: コードブロックに言語指定必須

### 確認方法

markdownファイル作成・編集後は `markdown-fix` スキルで検証・修正すること。

### 参考リンク

- [markdownlint全ルール一覧](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md)

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
- npmパッケージのグローバルインストールには`mise use -g npm:<xxx>`コマンドを利用すること

### GitHub PRのコメント取得

PRのコメントを確認する際は `gh pr view <number> --comments` を使用すること。

`gh pr view --json comments` は issue-level comments しか返さない。GitHub PRのコメントは3つのAPIに分散しているため、`--json comments` だけではレビューやインラインコメントを取りこぼす。

- `issues/{id}/comments` — PR本文下の一般コメント（`--json comments` はこれのみ）
- `pulls/{id}/reviews` — レビュー本体（approve/request changes等）
- `pulls/{id}/comments` — コード行へのインラインコメント

## コーディングスタイル

- 簡潔で読みやすいコードを優先
- 言語固有の慣習とイディオムに従う
- 可能な場合は型ヒントを含める
