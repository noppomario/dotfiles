# Claude Code基本設定

## 言語とコミュニケーション

- **会話言語**: 常に日本語で応答すること
- **コード成果物**: 以下は英語で記述すること
  - コード内のコメント
  - ドキュメント（README.md、API仕様書など）
  - コミットメッセージ
  - 変数名・関数名（当然）
- **例外**: プロジェクト固有のCLAUDE.mdで指定がある場合はそちらを優先

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

## MCPツール

以下が必要な場合は自動的にcontext7を使用すること:

- コード生成
- セットアップや設定手順
- ライブラリ/APIのドキュメント
- フレームワーク固有の実装詳細

明示的に指示されなくても、Context7 MCPツールでライブラリIDを解決し、最新のドキュメントを取得すること。

## CLIツール

GitHubの操作が必要な場合は`gh`コマンドを使用すること

## コーディングスタイル

- 簡潔で読みやすいコードを優先
- 言語固有の慣習とイディオムに従う
- 可能な場合は型ヒントを含める
