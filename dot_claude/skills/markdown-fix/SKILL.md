---
name: markdown-fix
description: Markdownファイルをmarkdownlint-cli2で自動修正。markdownファイルを追加/編集した場合は必ず実行する。「markdown fix」「markdownlint実行」等で起動
allowed-tools: Bash(markdownlint-cli2 *), Edit(*.md:*)
---

# Markdwonドキュメントフォーマットスキル

全markdownファイルをmarkdownlintルールに準拠させる:

1. 対象ファイルの一覧を取得する。.gitignoreを尊重し対象から除外する。
2. `markdownlint-cli2 --fix "**/*.md"` で自動修正
3. `markdownlint-cli2 "**/*.md"` で残存エラー確認
4. 修正結果とエラーをユーザーに報告

**重要**: 自動修正できないエラーは手動修正が必要な旨を伝える
