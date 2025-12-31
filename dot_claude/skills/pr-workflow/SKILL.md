---
name: pr-workflow
description: セッション完了時のPR作成ワークフロー。「PRを作って」「これでPR出して」「PR作成」「PR化」等で起動
allowed-tools: Bash(git *), Bash(gh *)
---

# セッション完了時のPR作成ワークフロー

セッション完了時、以下を自動実行:

1. 変更内容確認: `git status`
2. Claude Codeのメモリ更新が必要な場合は実施し、修正差分に含める
3. 適切なブランチ名提案(feature/YYYYMMDD-description)
4. コミットメッセージ生成
5. `gh pr create`でPR作成

**重要**: push前に必ずユーザーに確認を取る
**重要**: ステージング済の修正がある場合は追加でステージングせず、今ステージングされている内容をコミット/pushする必要があるのだと解釈する(混ぜない)
