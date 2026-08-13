---
version: alpha
name: nkos-dev-top-design
description: "nkos.dev のトップページ（観測盤レイアウト）のデザインシステム。ほぼ黒の #0a0a0c を盤面とし、1px の罫線だけで区切られたモジュールを一画面に敷き詰める計器パネル。角丸と影を一切使わず、階層は罫線と余白のみで作る。有彩色は真鍮色 #d2a857 ひとつに絞り、ラベル・計測値・強調にのみ使う。見出しは可変フォント Archivo（wdth 軸を持つ）、本文は Zen Kaku Gothic New。表示時は罫線がスケールで引かれ、銘板ラベルが通電するように明滅し、可変フォントの字幅が広がって名前が定位置に収まる、という時間差のある立ち上がりを持つ。※ このファイルはトップページ専用。サイト内の他ページは別系統のデザイン（紫アクセント＋角丸カード＋オーブ背景）であり、このトークンを適用してはならない。"

colors:
  ink: "#0a0a0c"
  panel: "#0e0e12"
  line: "rgba(255, 255, 255, 0.09)"
  line-soft: "rgba(255, 255, 255, 0.05)"
  paper: "#f4f4f2"
  grey: "#a0a0ab"
  dim: "#7e7e8c"
  brass: "#d2a857"
  brass-border: "rgba(210, 168, 87, 0.5)"
  brass-fill: "rgba(210, 168, 87, 0.08)"
  brass-hover: "rgba(210, 168, 87, 0.07)"
  scrim: "rgba(10, 10, 12, 0.88)"

typography:
  identity:
    fontFamily: Archivo
    fontSize: "clamp(46px, 6.2vw, 102px)"
    fontWeight: 700
    lineHeight: 0.9
    letterSpacing: -0.045em
    fontVariationSettings: "'wdth' 118, 'wght' 700"
  index-label:
    fontFamily: Archivo
    fontSize: "clamp(15px, 1.5vw, 20px)"
    fontWeight: 600
    lineHeight: 1.2
    letterSpacing: -0.01em
  work-name:
    fontFamily: Archivo
    fontSize: "clamp(15px, 1.4vw, 18px)"
    fontWeight: 600
    lineHeight: 1.35
    letterSpacing: -0.01em
  entry-title:
    fontFamily: Zen Kaku Gothic New
    fontSize: 14.5px
    fontWeight: 500
    lineHeight: 1.6
    letterSpacing: 0
  body:
    fontFamily: Zen Kaku Gothic New
    fontSize: 16px
    fontWeight: 400
    lineHeight: 1.7
    letterSpacing: 0
  body-sm:
    fontFamily: Zen Kaku Gothic New
    fontSize: 12.5px
    fontWeight: 400
    lineHeight: 1.7
    letterSpacing: 0
  body-xs:
    fontFamily: Zen Kaku Gothic New
    fontSize: 12px
    fontWeight: 400
    lineHeight: 1.75
    letterSpacing: 0
  control:
    fontFamily: Zen Kaku Gothic New
    fontSize: 11.5px
    fontWeight: 500
    lineHeight: 1.4
    letterSpacing: 0
  module-tag:
    fontFamily: Archivo
    fontSize: 10.5px
    fontWeight: 600
    lineHeight: 1.2
    letterSpacing: 0.24em
    textTransform: uppercase
  module-meta:
    fontFamily: Archivo
    fontSize: 10.5px
    fontWeight: 400
    lineHeight: 1.2
    letterSpacing: 0.14em
    textTransform: uppercase
  domain:
    fontFamily: Archivo
    fontSize: 12px
    fontWeight: 500
    lineHeight: 1.2
    letterSpacing: 0.28em
    textTransform: uppercase
  readout:
    fontFamily: Archivo
    fontSize: 11.5px
    fontWeight: 500
    lineHeight: 1.2
    letterSpacing: 0.14em
  stamp:
    fontFamily: Archivo
    fontSize: 10.5px
    fontWeight: 400
    lineHeight: 1.2
    letterSpacing: 0.16em
  rail-clock:
    fontFamily: Archivo
    fontSize: 10px
    fontWeight: 400
    lineHeight: 1.2
    letterSpacing: 0.22em
    fontVariantNumeric: tabular-nums
    writingMode: vertical-rl
  rail-text:
    fontFamily: Archivo
    fontSize: 10px
    fontWeight: 500
    lineHeight: 1.2
    letterSpacing: 0.3em
    writingMode: vertical-rl

rounded:
  none: 0px

spacing:
  xxs: 5px
  xs: 6px
  sm: 10px
  md: 12px
  lg: 18px
  xl: 22px
  module: "clamp(16px, 1.8vw, 26px)"
  module-head: "clamp(10px, 1.4vh, 18px)"
  gutter: "clamp(16px, 2.5vw, 32px)"
  rail: 46px

components:
  rail:
    backgroundColor: "{colors.ink}"
    textColor: "{colors.dim}"
    typography: "{typography.rail-text}"
    rounded: "{rounded.none}"
    width: "{spacing.rail}"
    padding: "24px 0 26px"
    border: "0 1px 0 0 {colors.line} solid"
  module:
    backgroundColor: "{colors.ink}"
    textColor: "{colors.grey}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.none}"
    padding: "{spacing.module}"
    border: "1px solid {colors.line} (left rule drawn as a positioned element)"
  module-head:
    backgroundColor: "transparent"
    textColor: "{colors.brass}"
    typography: "{typography.module-tag}"
    rounded: "{rounded.none}"
    padding: "0 0 {spacing.module-head}"
  rule-v:
    backgroundColor: "{colors.line}"
    rounded: "{rounded.none}"
    width: 1px
  rule-h:
    backgroundColor: "{colors.line}"
    rounded: "{rounded.none}"
    height: 1px
  rule-soft:
    backgroundColor: "{colors.line-soft}"
    rounded: "{rounded.none}"
    height: 1px
  identity-name:
    backgroundColor: "transparent"
    textColor: "{colors.paper}"
    typography: "{typography.identity}"
    rounded: "{rounded.none}"
  plate:
    backgroundColor: "{colors.panel}"
    rounded: "{rounded.none}"
    border: "1px solid {colors.line}"
    filter: "grayscale(1) sepia(0.42) hue-rotate(-10deg) saturate(1.35) contrast(1.04)"
  fact-mark:
    backgroundColor: "transparent"
    textColor: "{colors.brass}"
    rounded: "{rounded.none}"
    border: "1px solid {colors.line}"
    width: 24px
    height: 24px
  fact-mark-hover:
    backgroundColor: "{colors.brass-fill}"
    textColor: "{colors.brass}"
    rounded: "{rounded.none}"
    border: "1px solid {colors.brass-border}"
  frame:
    backgroundColor: "{colors.panel}"
    rounded: "{rounded.none}"
    border: "1px solid {colors.line}"
  frame-caption:
    backgroundColor: "{colors.scrim}"
    textColor: "{colors.paper}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.none}"
    padding: "30px 14px 12px"
  tick:
    backgroundColor: "{colors.line}"
    rounded: "{rounded.none}"
    width: 28px
    height: 2px
  tick-selected:
    backgroundColor: "{colors.brass}"
    rounded: "{rounded.none}"
    width: 28px
    height: 2px
  chip:
    backgroundColor: "transparent"
    textColor: "{colors.dim}"
    typography: "{typography.control}"
    rounded: "{rounded.none}"
    padding: "5px 10px"
    border: "1px solid {colors.line}"
  chip-hover:
    backgroundColor: "transparent"
    textColor: "{colors.paper}"
    typography: "{typography.control}"
    rounded: "{rounded.none}"
    padding: "5px 10px"
    border: "1px solid {colors.dim}"
  chip-selected:
    backgroundColor: "{colors.brass}"
    textColor: "{colors.ink}"
    typography: "{typography.control}"
    rounded: "{rounded.none}"
    padding: "5px 10px"
    border: "1px solid {colors.brass}"
  icon-token:
    backgroundColor: "transparent"
    textColor: "{colors.grey}"
    rounded: "{rounded.none}"
    width: 40px
    height: 40px
    glyphSize: "17-25px"
  readout:
    backgroundColor: "transparent"
    textColor: "{colors.brass}"
    typography: "{typography.readout}"
    rounded: "{rounded.none}"
    padding: "12px 0 0"
  list-row:
    backgroundColor: "transparent"
    textColor: "{colors.dim}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.none}"
    padding: "13px 0"
    border: "0 0 1px {colors.line-soft} solid"
  list-row-hover:
    backgroundColor: "transparent"
    textColor: "{colors.dim}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.none}"
    padding: "13px 0 13px 8px"
  text-link:
    backgroundColor: "transparent"
    textColor: "{colors.grey}"
    typography: "{typography.body-sm}"
    rounded: "{rounded.none}"
    padding: "18px 0 0"
  index-item:
    backgroundColor: "transparent"
    textColor: "{colors.paper}"
    typography: "{typography.index-label}"
    rounded: "{rounded.none}"
    padding: "clamp(15px, 1.8vw, 24px) clamp(16px, 1.8vw, 26px)"
  index-item-hover:
    backgroundColor: "{colors.brass-hover}"
    textColor: "{colors.paper}"
    typography: "{typography.index-label}"
    rounded: "{rounded.none}"
  focus-ring:
    outline: "1px solid {colors.brass}"
    outlineOffset: "2px"
    rounded: "{rounded.none}"
---

## Overview

nkos.dev のトップページは、カードを積む一般的なポートフォリオではなく、**一画面に情報を敷き詰めた計器パネル（観測盤）** として設計されている。盤面は `{colors.ink}`（#0a0a0c）、その上に **1px の罫線だけで区切られたモジュール** が格子状に並ぶ。角丸は 0、影は 0。階層は面の明度差ではなく、罫線・余白・文字サイズだけで作る。

有彩色は **真鍮色 `{colors.brass}`（#d2a857）ひとつだけ**。ラベル（モジュール名）、計測値（時刻・日付・読み取り欄）、選択状態、フォーカスリングにのみ現れる。それ以外はすべて無彩色（`{colors.paper}` / `{colors.grey}` / `{colors.dim}`）で、写真も真鍮寄りのセピアに寄せてから、ホバーで初めて本来の色に戻る。

タイポグラフィは 2 系統。ラテン文字は可変フォント **Archivo**（`wdth` 62–125 / `wght` 400–700）で、見出しは字幅 118 まで広げて盤面いっぱいに張る。日本語と操作系ラベルは **Zen Kaku Gothic New**。ラベル類はすべて大文字＋広いトラッキング（0.14em–0.3em）で、計器の銘板として読ませる。

立ち上がりの演出はこのデザインの本体と言ってよい。罫線が `scaleX` / `scaleY` で引かれ、モジュール名が通電するように明滅（`flicker`）し、可変フォントの字幅が広がって（`expand`）名前が定位置に収まる。この時間差（40ms → 1000ms 超）が「盤面に電源が入る」印象を作る。

**Key Characteristics:**
- **角丸ゼロ・影ゼロ。** 区切りはすべて 1px の罫線。
- **1 色だけの有彩色**（真鍮 `{colors.brass}`）。それ以外は無彩色で押し通す。
- **罫線は border ではなく要素**（`.vline` / `.hline`）。引かれる向き・順番・速度を制御するため。
- **一画面完結**（幅 1001px 以上かつ高さ 760px 以上で `height: 100dvh; overflow: hidden`）。
- ラベルは大文字＋広いトラッキング、見出しは負のトラッキング（-0.045em）という強い対比。
- モジュールの角に **トンボ**（8px → 15px に伸びる L 字）が浮かぶ。
- ブランドアイコンは既定で単色。**指したときだけ**本来のブランド色になる。

## Colors

> 抽出元: `src/index.css`（`:root` のトップページ用トークン）、`src/App.css`。

### Brand & Accent
- **Brass** ({colors.brass}): 唯一の有彩色。#d2a857。モジュール名、時刻、日付、読み取り欄、選択中チップの塗り、フォーカスリング、ホバー時の矢印。
- **Brass Border** ({colors.brass-border}): 真鍮 50%。ホバー時のアイコン枠線。
- **Brass Fill** ({colors.brass-fill}): 真鍮 8%。ホバー時のアイコン枠の内側。
- **Brass Hover** ({colors.brass-hover}): 真鍮 7%。ナビ項目のホバー面。**面を塗る唯一の有彩色で、必ずこの薄さに留める。**

### Surface
- **Ink** ({colors.ink}): 盤面の背景。#0a0a0c。純黒にしない。
- **Panel** ({colors.panel}): 画像枠など、一段だけ沈める面。#0e0e12。段は 1 段しか持たない。
- **Line** ({colors.line}): 主罫線。白 9%。モジュール間の区切り、枠線、アイコン枠。
- **Line Soft** ({colors.line-soft}): 従罫線。白 5%。リスト行の区切りなど、モジュール内部の細分。
- **Scrim** ({colors.scrim}): 写真キャプションの下に敷く暗幕。`linear-gradient(to top, {colors.scrim}, transparent)`。

### Text
- **Paper** ({colors.paper}): 見出し・項目名・選択中の要素。#f4f4f2。純白にしない。
- **Grey** ({colors.grey}): 本文。#a0a0ab（`{colors.ink}` に対して約 7.4:1）。
- **Dim** ({colors.dim}): 注記・メタ情報・非選択状態。#7e7e8c（約 4.9:1）。**これ以上暗い文字色を追加しない。**

### Brand Color Exception

技術スタックのアイコン（simple-icons）は既定では `{colors.grey}` の単色で描く。**ポインタが乗ったアイコン 1 つだけ**が本来のブランド色（`#{icon.hex}`）になり、同時に他は不透明度 0.32 まで引く。GitHub / Vercel のようにブランド色が黒に近く盤面で沈むものは `{colors.paper}` に置き換える。これが「真鍮 1 色」の唯一の例外であり、常時発色させてはならない。

## Typography

### Font Family

- **Archivo**（可変・`wdth` 62..125 / `wght` 400..700）— ラテン文字すべて。見出し、ラベル、数値、ナビ項目名。CSS 変数 `--display`。
- **Zen Kaku Gothic New**（400 / 500 / 700）— 日本語本文、注記、操作系ラベル。CSS 変数 `--jp`。

Google Fonts から 1 リクエストで読み込む。フォールバックは `system-ui, 'Hiragino Sans', 'Noto Sans JP', sans-serif`。

### Hierarchy

| Token | Size | Weight | Tracking | Use |
|---|---|---|---|---|
| `{typography.identity}` | clamp(46px, 6.2vw, 102px) | 700 (`wdth` 118) | -0.045em | 名前。盤面で唯一の巨大文字 |
| `{typography.index-label}` | clamp(15px, 1.5vw, 20px) | 600 | -0.01em | 最下段ナビの項目名 |
| `{typography.work-name}` | clamp(15px, 1.4vw, 18px) | 600 | -0.01em | 制作物の名前 |
| `{typography.entry-title}` | 14.5px | 500 | 0 | 記事タイトル（日本語） |
| `{typography.body}` | 16px / 1.7 | 400 | 0 | 盤面の基準サイズ |
| `{typography.body-sm}` | 12.5px / 1.7 | 400 | 0 | 注記、キャプション、リンク文言 |
| `{typography.body-xs}` | 12px / 1.75 | 400 | 0 | 記事の抜粋（2 行でクランプ） |
| `{typography.control}` | 11.5px | 500 | 0 | カテゴリチップ |
| `{typography.module-tag}` | 10.5px | 600 | 0.24em / 大文字 | モジュール名（真鍮） |
| `{typography.module-meta}` | 10.5px | 400 | 0.14em / 大文字 | モジュール右肩の件数表示 |
| `{typography.domain}` | 12px | 500 | 0.28em / 大文字 | ドメイン表記 |
| `{typography.readout}` | 11.5px | 500 | 0.14em | 読み取り欄（指した対象の名前） |
| `{typography.stamp}` | 10.5px | 400 | 0.16em | 日付、補助ラベル |
| `{typography.rail-clock}` | 10px | 400 | 0.22em / 縦組み | 左端の時計（等幅数字） |
| `{typography.rail-text}` | 10px | 500 | 0.3em / 縦組み | 左端の銘板テキスト |

### Principles

- **ラベルは大文字＋広いトラッキング、見出しは負のトラッキング。** この対比が計器の見え方を作る。ラベルを小文字にしたり、トラッキングを詰めたりしない。
- **可変フォントの `wdth` 軸を使う。** 名前は `wdth` 118 に張り出す。単なる `font-weight` の変更で代用しない。
- **数値は必ず `font-variant-numeric: tabular-nums`。** 時計が毎秒ガタつくのを防ぐ。
- **縦組み（`writing-mode: vertical-rl` + `rotate: 180deg`）は左端の銘板専用。** 他の場所に持ち込まない。
- 日本語とラテン文字で family を切り替える。日本語に Archivo を当てない。

## Layout

### Spacing System

- **基準**: 4px グリッドには厳密に乗せず、罫線基準で目に合わせている。主な刻みは 5 / 6 / 10 / 12 / 18 / 22px。
- **モジュール内側**: `{spacing.module}` = `clamp(16px, 1.8vw, 26px)`。ビューポートに追従させる。
- **モジュール見出しの下**: `{spacing.module-head}` = `clamp(10px, 1.4vh, 18px)`。
- **リスト行の上下**: 13px。ホバーで左に 8px 押し込む（`padding-left` の遷移）。

### Grid & Container

```
┌──────┬─────────────────────────────────────────────┐
│      │  Identity            │  Gallery             │  row--a  7fr : 5fr
│ rail ├──────────────────────┴──────────────────────┤
│ 46px │  Stack   │   Works   │   Log                │  row--b  1fr : 1fr : 1fr
│      ├──────────┴───────────┴──────────────────────┤
│      │  About │ Blog │ Works │ GitHub              │  index-nav  4 列
└──────┴─────────────────────────────────────────────┘
```

- 盤面全体は `grid-template-columns: {spacing.rail} minmax(0, 1fr)`。左 46px は縦組みの銘板（時計＋固定テキスト）。
- 本体は 3 行。`min-content` / `minmax(min-content, 1fr)` / `min-content`。
- **幅 1001px 以上かつ高さ 760px 以上のとき、`height: 100dvh; overflow: hidden` で一画面に収める。** 行比は `0.85fr : 1fr : min-content` とし、余った高さは Gallery と Stack の面が伸びて吸う。
- 一画面固定を成立させるため、**各モジュールは面の下端に着く要素を 1 つ持つ**（注記帯 / 読み取り欄 / 「ほかの制作物」リンク）。`margin-top: auto` で下端に寄せることで、面が伸びても宙に浮いた空白にならない。

### Whitespace Philosophy

盤面は密であることが前提。余白でセクションを離すのではなく、**罫線で仕切る**。セクション間に大きな空白（48px 以上）を作らない。

## Elevation & Depth

| Level | Treatment | Use |
|---|---|---|
| 0 | 背景 `{colors.ink}`、装飾なし | 本文、モジュールの地 |
| 1 | 1px `{colors.line}` の罫線で区切る | モジュール間、アイコン枠、画像枠 |
| 1s | 1px `{colors.line-soft}` の罫線 | モジュール内部のリスト区切り |
| 2 | 背景 `{colors.panel}` + 1px `{colors.line}` | 画像枠の地（読み込み前の面） |
| hover | 背景 `{colors.brass-hover}`（真鍮 7%） | ナビ項目のみ |
| focus | 1px `{colors.brass}` の outline、offset 2px | すべての操作要素 |

**`box-shadow` は使わない。** 明度の段も `{colors.panel}` の 1 段しか持たない。奥行きは罫線と余白だけで表す。

### Decorative Depth

各モジュールの左上と右下に、`::before` / `::after` で L 字のトンボ（8×8px、1px `{colors.brass}`）を置く。既定は `opacity: 0`、ホバーで `opacity: 0.8` かつ 15×15px に伸びる。**盤面で唯一の「装飾」で、これ以外の飾りを足さない。**

## Shapes

### Border Radius Scale

| Token | Value | Use |
|---|---|---|
| `{rounded.none}` | 0px | すべて |

例外はない。ボタン、チップ、画像枠、アバター、インジケータ——すべて直角。**円形アバターも角丸カードも、この盤面には存在しない。**

### Imagery Treatment

写真は枠（1px `{colors.line}`）に収め、`filter: grayscale(1) sepia(0.42) hue-rotate(-10deg) saturate(1.35) contrast(1.04)` で真鍮寄りに寄せる。**明度は落とさない**（暗くするのではなく色味だけ変える）。ホバーで `filter: none` に戻す。

### Icon Framing

アイコンは直に置かず、24px（注記帯）または 40px（スタック）の**正方形の枠に収める**。当たり判定を枠に一本化することで、字形の違いが拾いやすさの差にならない。

## Components

> ホバー状態はこの盤面の情報設計の一部（読み取り欄・ブランド色の発色）であるため、意図的に記載している。

### Structure

**`rail`** — 左端の銘板。盤面の縁を締める幅 46px の柱。
- 背景 `{colors.ink}`、文字 `{colors.dim}`、タイポグラフィ `{typography.rail-text}`、幅 `{spacing.rail}`、padding `24px 0 26px`、右端のみ 1px `{colors.line}`。
- 上に時計（`{typography.rail-clock}`、`Asia/Tokyo`、毎秒更新）、下に固定テキスト。両方とも縦組み。
- 1000px 以下では非表示。

**`module`** — 盤面の基本単位。
- 背景 `{colors.ink}`、文字 `{colors.grey}`、タイポグラフィ `{typography.body-sm}`、padding `{spacing.module}`。
- 左端に縦罫（行の先頭モジュールでは引かない）。角にトンボ。

**`module-head`** — モジュール上部の見出し帯。
- 文字 `{colors.brass}`、タイポグラフィ `{typography.module-tag}`、padding `0 0 {spacing.module-head}`。
- 左 = 真鍮のモジュール名、右 = メタ情報 `{typography.module-meta}`（件数表示）。

**`rule-v`** / **`rule-h`** / **`rule-soft`** — 罫線要素。
- `rule-v`: 幅 1px、背景 `{colors.line}`。`rule-h`: 高さ 1px、背景 `{colors.line}`。
- `rule-soft`: 高さ 1px、背景 `{colors.line-soft}`。モジュール内部の細分に使う。
- **`border` ではなく要素として置く。** 引かれる向き・順番・速度を制御するため。

### Identity

**`identity-name`** — 盤面で唯一の巨大文字。
- 文字 `{colors.paper}`、タイポグラフィ `{typography.identity}`（`wdth` 118 まで張り出す）。

### Controls

**`chip`** / **`chip-hover`** / **`chip-selected`** — カテゴリチップ。
- 既定: 文字 `{colors.dim}`、背景なし、1px `{colors.line}`、タイポグラフィ `{typography.control}`、padding `5px 10px`。
- ホバー: 文字 `{colors.paper}`、枠 `{colors.dim}`。
- 選択: 背景 `{colors.brass}`、文字 `{colors.ink}`（**盤面で唯一、真鍮を面として塗る要素**）。
- 右肩に件数を `{typography.stamp}` 相当・`opacity: 0.75` で添える。

**`focus-ring`** — すべての操作要素に共通。
- `outline: 1px solid {colors.brass}`、`outline-offset: 2px`。

### Media

**`frame`** — 画像枠。
- 背景 `{colors.panel}`、1px `{colors.line}`、角丸なし。
- 複数枚は重ねて `opacity` を 0.9s で切り替える（4.6 秒ごとに送る）。

**`frame-caption`** — 画像枠下端のキャプション。
- 背景 `{colors.scrim}`（上向きグラデーションの暗幕）、文字 `{colors.paper}`、タイポグラフィ `{typography.body-sm}`、padding `30px 14px 12px`。`MapPin` 13px は真鍮。

**`tick`** / **`tick-selected`** — 送りインジケータ。
- 28×2px の直線。既定は `{colors.line}`、選択中のみ `{colors.brass}`。
- **ドット型のインジケータにしない。**

**`plate`** — 写真の面そのもの。
- 背景 `{colors.panel}`、1px `{colors.line}`、`filter: grayscale(1) sepia(0.42) hue-rotate(-10deg) saturate(1.35) contrast(1.04)`。ホバーで `filter: none`。

### Data Display

**`icon-token`** — 漂うアイコン。
- 40×40px の正方形、中の字形は 17–25px、文字 `{colors.grey}`。位置は `--x` / `--y`（%）で絶対配置し、`translate: -50% -50%` で中心合わせ。
- **中心合わせは `translate`、漂いは `transform`、拡大は `scale` と、別プロパティに分ける。** 同じ `transform` に入れると互いを打ち消す。
- 面にポインタが乗っている間は `animation-play-state: paused`（動いていても選べる）。
- ホバー中のもの: `scale: 1.42`、色はブランド色。それ以外: `opacity: 0.32`。絞り込みで外れたもの: `opacity: 0.14`。
- 位置は乱数ではなく `sin` ベースの決定的なゆらぎで作る（再描画で配置が飛ばない）。表示ごとに変えるのは**どのアイコンがどの枠に入るか**だけ。

**`readout`** — 読み取り欄。
- 文字 `{colors.brass}`、タイポグラフィ `{typography.readout}`、padding `12px 0 0`。
- `margin-top: auto` で面の底に着き、指した対象の名前を表示する。アイコンだけでは名前が読めないことへの答えであり、**アイコンを並べる面には必ず対で置く**。

**`list-row`** / **`list-row-hover`** — リスト行（制作物 / 記事）。
- 文字 `{colors.dim}`、タイポグラフィ `{typography.body-sm}`、padding `13px 0`、区切りは下辺 1px `{colors.line-soft}`。
- ホバーで `padding-left: 8px`（行が右に押し出される）。矢印（`ArrowUpRight` 15px）はホバーで `{colors.brass}` になり `translate(3px, -3px)`。
- 制作物: 名前 `{typography.work-name}` + 注記 `{typography.body-sm}`（`{colors.dim}`）。
- 記事: 日付 `{typography.stamp}`（真鍮、`YYYY.MM.DD`）+ タイトル `{typography.entry-title}` + 抜粋 `{typography.body-xs}`（2 行クランプ）。

**`fact-mark`** / **`fact-mark-hover`** — 注記帯のアイコン枠。
- 24×24px、文字 `{colors.brass}`、1px `{colors.line}`、背景なし。
- ホバー: 背景 `{colors.brass-fill}`、枠 `{colors.brass-border}`。

### Navigation

**`index-item`** / **`index-item-hover`** — 最下段ナビ。
- 文字 `{colors.paper}`、タイポグラフィ `{typography.index-label}`、padding `clamp(15px, 1.8vw, 24px) clamp(16px, 1.8vw, 26px)`。
- 4 列（1000px 以下で 2 列、560px 以下で 1 列）。項目名 + 日本語の注記 11px（`{colors.dim}`）+ 右端の矢印。
- ホバーで面が `{colors.brass-hover}` に染まり、矢印が真鍮になって右上へ 3px 動く。
- 内部リンクは `ArrowUpRight`、外部リンクは `ExternalLink` で行き先を区別する。

**`text-link`** — モジュール下端の補助リンク（「ほかの制作物」など）。
- 文字 `{colors.grey}`、タイポグラフィ `{typography.body-sm}`、padding `18px 0 0`。

## Motion

罫線と文字が「順に立ち上がる」時間割そのものが、このデザインの署名になっている。

| Keyframe | Duration / Easing | 対象 |
|---|---|---|
| `draw-x` / `draw-y` | 0.44–0.46s `cubic-bezier(0.4, 0, 0.2, 1)` | 罫線が `scaleX/scaleY: 0 → 1` で引かれる |
| `drop-in` | 0.75s `cubic-bezier(0.16, 1, 0.3, 1)` | 銘板が上から落ちる |
| `flicker` | 0.42s `steps(1, end)` | モジュール名が通電するように明滅 |
| `expand` | 1.05s `cubic-bezier(0.16, 1, 0.3, 1)` | 名前の字幅が `wdth` 64 → 118 に広がる |
| `fade-in` | 0.55–0.6s `cubic-bezier(0.16, 1, 0.3, 1)` | 中身が 10px 下から立ち上がる |
| `fade-in-left` | 0.55s 同上 | ナビの英字だけ左から 24px 滑り込む |
| `drift` | 7–14s `ease-in-out infinite alternate` | アイコンが漂う |

**時間割:** 横罫 40ms → 120ms → 銘板 180–380ms → 縦罫 260ms + 40ms×i → モジュール名 400ms + 45ms×i → メタ 900ms + 45ms×i → 中身 960ms + 45ms×i → 名前 1020ms → ナビ 1000ms + 75ms×k。

**`animation-fill-mode` は原則 `backwards`。** `forwards` にすると終了値が固定され、フィルタなど通常のスタイルが効かなくなる。引き終えた状態を保つ必要がある罫線だけ `forwards` を使う。

`prefers-reduced-motion: reduce` では、盤面配下のすべてのアニメーションと遷移を 0.001ms に潰す（`animation-iteration-count: 1` も含む）。

## Do's and Don'ts

### Do

- 区切りは 1px の罫線で引く。主罫は `{colors.line}`、モジュール内部の細分は `{colors.line-soft}`。
- 有彩色は `{colors.brass}` だけを、ラベル・計測値・選択状態・フォーカスに使う。
- ラベルは大文字＋トラッキング 0.14em 以上。見出しは負のトラッキング。
- 面を伸ばすときは、下端に着く要素（`margin-top: auto`）を必ず 1 つ持たせる。
- アイコンは正方形の枠に収め、当たり判定を枠に統一する。
- アイコンだけで示した情報には、名前を出す読み取り欄を対で置く。
- ホバーは「押し込む（`padding-left`）」「伸びる（トンボ）」「点く（真鍮）」の 3 種に留める。
- 決定的なゆらぎ（`sin` ベース）を使い、再描画で配置が変わらないようにする。
- 数値表示には `tabular-nums` を指定する。

### Don't

- **角丸を使わない**（`border-radius` は 0 以外を書かない）。
- **`box-shadow` を使わない。** グロー表現も含めて禁止。
- **真鍮以外の有彩色を足さない。** 紫・シアン・ピンクは旧デザイン（他ページ）のものであり、この盤面に持ち込まない。
- **オーブやぼかしたグラデーション背景を置かない。**
- 真鍮を広い面の塗りに使わない（例外は選択中チップと、7% の薄いホバー面のみ）。
- ブランドアイコンを常時発色させない。指した 1 つだけを色付ける。
- `{colors.dim}` より暗い文字色を追加しない（コントラスト 4.9:1 が下限）。
- 純黒 `#000000` / 純白 `#ffffff` を使わない。
- 絵文字を使わない。アイコンは `lucide-react`（線）と `simple-icons`（ブランド）から取る。
- 写真の明度を落として沈めない。色味だけをセピア側へ寄せ、ホバーで戻す。
- ライトテーマを作らない。この盤面は暗色前提。

## Responsive Behavior

### Breakpoints

| Name | Condition | Key Changes |
|---|---|---|
| Board | `min-width: 1001px` かつ `min-height: 760px` | 一画面固定（`100dvh` / `overflow: hidden`）、行比 0.85fr : 1fr : min-content |
| Desktop | `min-width: 1001px` | 2 列 + 3 列 + 4 列の格子。スクロール可 |
| Tablet 以下 | `max-width: 1000px` | 銘板を非表示、全モジュールを 1 列に縦積み、ナビ 2 列 |
| Mobile | `max-width: 560px` | ナビ 1 列 |

### Touch Targets

- アイコンの当たり判定は 40×40px を確保。
- 送りインジケータ（`tick`）は 28×2px だが、実際のボタン領域はそれ以上を確保すること。
- ホバー前提の情報（読み取り欄、ブランド色）は、タッチ環境では既定表示（件数・単色）で意味が通るようにしてある。**ホバーでしか得られない必須情報を作らない。**

### Collapsing Strategy

縦積みになると縦罫は意味を失うため、**`.vline` を `display: none` にし、区切りを `border-top` に切り替える**。罫線の向きは常にレイアウトの積み方向と直交させる。ナビも同様に、列数に応じてどの縦罫を消すかを切り替える（2 列なら奇数番目、1 列ならすべて）。

### Fluid Sizing

- モジュール内側、見出し、ナビの余白は `clamp()` でビューポートに追従させる（メディアクエリで段階的に切らない）。
- 名前は `clamp(46px, 6.2vw, 102px)`。

### Image Behavior

- 顔写真は 1000px 以下で `min(28%, 128px)`、560px 以下で `min(30%, 104px)`。
- 画像枠の最小高さはデスクトップ 190px、1000px 以下で 200px。

## Iteration Guide

1. 新しい要素を足すときは、まず **どのモジュールに属するか** を決める。モジュールの外に独立した要素を置かない。
2. 区切りが必要になったら、`border` ではなく罫線要素（`rule-v` / `rule-h`）で引けるか検討する（引く順番を制御したい場合）。
3. 色を足したくなったら、まず `{colors.grey}` / `{colors.dim}` の使い分けで解けないか確認する。真鍮を増やす判断は最後。
4. アニメーションを足すときは、既存の時間割（40ms → 1020ms）のどこに差し込むかを決めてから書く。
5. 面が縦に伸びる可能性があるなら、下端に着く要素を用意する。
6. 実装は `src/App.css` に閉じる。旧デザインのページは `--old-*` トークンを参照しており、そちらへ影響を出さない。

## Known Gaps

- このファイルはトップページ（`src/App.jsx` / `src/App.css`）専用。About / Blog / ComingSoon / Troll は `--old-*` 系トークン（紫 #a78bfa、角丸 12px、オーブ背景）の別デザインで、統合されていない。
- `{colors.panel}` 以外の面の段（surface ladder）は存在しない。より深い階層が必要になった場合の値は未定義。
- エラー表示・フォーム入力・トースト等の状態表現はトップページに存在しないため未定義（`semantic-*` 系の色トークンを持たない）。
- ライトテーマは定義しない（`color-scheme: dark` 固定）。
- Gallery の写真は現状ダミー（同一画像を `object-position` で切り替え）。実写真投入時に `filter` の強度を再調整する余地がある。
