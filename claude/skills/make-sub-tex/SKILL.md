---
name: make-sub-tex
description: |
  Generate sub.tex — a private speaker-notes copy of main.tex with red supplementary annotations added throughout.
  Use this skill when the user says 「sub.texを作って」「発表用サブを作って」「補足テックスを作って」「手元用資料を作って」「発表用メモを作って」,
  types /make-sub-tex, or mentions they are about to present and want an annotated version to read privately during the presentation.
  The audience-facing PDF comes from main.tex; the presenter reads sub.tex on their own screen.
  Do NOT trigger for requests to edit or compile main.tex itself.
---

# make-sub-tex

Generate `sub.tex` from `main.tex` by inserting red `\textcolor{red}{...}` annotations to help the presenter
during a live seminar or Q&A. Original document content is never modified — annotations are purely additive.

## Before starting — always confirm first

Before doing anything, say this to the user and wait for explicit confirmation:

> 「main.tex の内容はこれで最終版ですか？後で main.tex を更新した場合は、このスキルを再度呼んで sub.tex を作り直す必要があります。生成を始めてよいですか？」

Only proceed after the user says yes (or equivalent).

## What to annotate and where

Insert `\textcolor{red}{...}` blocks at the following locations. Write every annotation in Japanese.
Do not alter existing LaTeX content in any way — not even whitespace.

### 1. After each `\section{...}` heading

A one-line summary of what this section argues — the single point it must land.

```latex
\section{進捗}
\textcolor{red}{【このセクションの要点】評価教示の設計方針と先行研究の知見を整理し、基準を明示しない設計の正当性を示す。}
```

### 2. After each `\subsection{...}` and `\subsubsection{...}` heading

A brief note on the key claim of that subsection.

### 3. Near technical terms — inline, on first occurrence

Immediately after the term, insert a compact parenthetical explanation.
The goal is to let the presenter answer "what does that mean?" without hesitation.

Key terms to watch for (not exhaustive — annotate any jargon):
- VAS-RRP: 複数Webサイトを1本のスライダー上で相対評価する手法
- VisAWI: Webサイト審美性の4因子測定尺度（Simplicity/Diversity/Colorfulness/Craftsmanship）
- プロトタイプ性: そのジャンルらしいデザインであること（Tuch 2012）
- 前注意的処理: 意識的注意の前に自動的に行われる視覚処理（~50–150ms）
- 古典的審美性 / 表現的審美性: Tractinsky (2000) の審美性2軸

```latex
VAS-RRP\textcolor{red}{（複数サイトを1本のスライダー上に相対配置して評価する手法）}
```

### 4. Near each `\cite{...}` reference

An inline note with the cited paper's author, year, and one-sentence claim.
Place it immediately after the closing `}` of the cite command.

```latex
\cite{ref1}\textcolor{red}{（Lindgaard 2006: 50ms以内にWebサイトの視覚的魅力判断が固まる、という50ms実験の出典）}
```

### 5. Before sections likely to draw questions

Insert a red anticipated Q&A block at a natural pause point — just before a topic the faculty or peers are likely to probe.

```latex
\textcolor{red}{【想定Q】「基準を明示しないと被験者間のばらつきが大きくなるのでは？」→ 意図的なトレードオフ。被験者数増加・提示時間制限・VAS-RRP相対評価・属性記録の4点で対処予定。方法論の節で正当化する。}
```

### 6. At the end of each major section (before `\newpage` or next `\section`)

A short block: what this section covered + the key takeaway for Q&A.

```latex
\textcolor{red}{【セクションまとめ】評価教示は「好き」という語で潜在的審美判断を引き出す設計。デメリット（信頼性・ノイズ）は意図的なトレードオフとして位置づけ、方法論の節で正当化する。}
```

## Workflow

1. **Confirm** (see "Before starting"). Do not proceed without a yes.
2. **Read `main.tex`** from the current working directory.
3. **Build the annotated version** in memory:
   - Add `\usepackage{xcolor}` immediately after the `\documentclass{...}` line if not already present.
   - Walk through the document, inserting annotations at the locations described above.
   - Never alter existing text, commands, or whitespace.
4. **Write** the result to `sub.tex` (overwrite if it already exists).
5. **Compile**: `latexmk -silent -outdir=out_sub sub.tex 2>&1`
6. If compilation fails due to an annotation error, fix the offending `\textcolor{...}` and recompile.
7. **Report in Japanese**: success or failure, a brief summary of what was annotated, and the path to `out_sub/sub.pdf`.

## Constraints

- Never modify original LaTeX content. All changes are additive.
- All annotation text must be in Japanese.
- Compilation output directory is `out_sub/` (distinct from `out/` used by main.tex).
- If sub.tex already exists, overwrite silently — the confirmation in step 1 covers this.
- Do NOT add `\usepackage{xcolor}` — `kostyle` already loads the `color` package with `dvipdfmx` option, and adding xcolor causes an "Option clash for package color" error. `\textcolor{red}{...}` works as-is.
- Do NOT use circled numbers (①②③…) in annotations — platex cannot process Unicode characters U+2460–U+2469. Use `(1)(2)(3)...` instead.
