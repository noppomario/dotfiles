---
name: mermaid-render
description: Mermaid図をPNG画像にレンダリングしVSCodeで表示。「/mermaid-render」「この図をレンダリング」「ダイアグラムを画像化」等で起動。
allowed-tools: Bash(mmdc *), Bash(mise exec *), Bash(code *)
---

# Mermaid図レンダラー

Mermaid記法の図をPNGにレンダリングしVSCodeで表示する:

1. タイムスタンプ付きファイル名を生成（例: `mermaid-20260207-194500.mmd`）
2. Mermaidソースをスクラッチパッドに書き出す
3. `mise exec -- mmdc -i <file>.mmd -o <file>.png -b white --scale 2` でレンダリング
4. `code <file>.png` でVSCodeに表示

**重要**: すべての一時ファイルはスクラッチパッドディレクトリに配置する
**重要**: ファイル名にタイムスタンプを含め、複数回実行しても前の出力を上書きしない
