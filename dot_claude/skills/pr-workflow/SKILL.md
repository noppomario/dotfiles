---
name: pr-workflow
description: セッション完了時のPR作成ワークフロー。「PRを作って」「これでPR出して」「プルリクエスト作成」等で起動
allowed-tools: Bash(git *), Bash(gh *)
---

# セッション完了時のPR作成ワークフロー

セッション完了時、以下を自動実行:

1. 変更内容確認: `git status`
2. 適切なブランチ名提案(feature/YYYYMMDD-description)
3. コミットメッセージ生成
4. `gh pr create`でPR作成

**重要**: push前に必ずユーザーに確認を取る
**重要**: ステージング済の修正がある場合は追加でステージングせず、今ステージングされている内容をコミット/pushする必要があるのだと解釈する(混ぜない)
