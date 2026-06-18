---
name: compile-latex
description: |
  Compile main.tex using latexmk and report the result in Japanese.
  Use this skill whenever the user says "コンパイルして", "ビルドして", "compile", "/compile-latex",
  or wants to build the LaTeX document and check for errors.
---

# compile-latex

Compile `main.tex` in this project using latexmk, then inspect the log and report clearly in Japanese.

## Steps

1. **Run latexmk** via Bash:
   ```
   cd /Users/n2530103/Documents/lab/進捗ゼミ/8 && latexmk -silent -outdir=out main.tex 2>&1
   ```
   Capture both stdout and stderr.

2. **Read the log** at `out/main.log`.

3. **Scan for errors and warnings**:
   - Error lines: lines starting with `!`, or containing `LaTeX Error`, `Error:`
   - Warning lines: lines containing `LaTeX Warning`, `Overfull`, `Underfull`
   - For each error found, also capture the 3 lines before and after for context.

4. **Report in Japanese**:
   - **成功の場合**: コンパイルが成功したことを一言で伝え、`out/main.pdf` が更新されたことを確認する。
   - **エラーがある場合**: エラー箇所をコンテキスト付きで列挙し、何を修正すべきか簡潔にまとめる。
   - **警告のみの場合**: 警告内容を報告しつつ、PDF自体は生成されたことを伝える。

## Constraints

- Do NOT edit `main.tex` — this skill only compiles and reports.
- If the log file does not exist after running, report that the compilation may have failed before producing output and show the command output instead.
