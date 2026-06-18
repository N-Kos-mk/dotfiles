---
name: tex-innyou
description: |
  Generate a LaTeX \bibitem citation entry and insert it into main.tex, using the exact
  formatting style of this project (\ti{} for italic journal names, \ti{\tb{}} for
  italic-bold volume numbers). Use this skill whenever the user says "引用を追加して",
  "文献を追加して", "bibitemを書いて", "この論文を引用して", types /tex-innyou,
  or pastes a paper reference/DOI and wants it added to the bibliography.
---

# tex-innyou

Add a new bibliography entry to `main.tex` in this project's citation format.

## Target format

```
\bibitem{refN}Author1 F.M., Author2 F.M. and Author3 F.M., Paper Title, \ti{Journal Name}, \ti{\tb{Volume}}, StartPage-EndPage (Year)
```

Key rules that make this format specific to this project:
- **Journal name** → wrapped in `\ti{}` (renders italic)
- **Volume number** → wrapped in `\ti{\tb{}}` (renders italic-bold)
- **Year** → in parentheses at the very end, no trailing period
- **Authors** → Western order "First [M.] Last", comma-separated, final author preceded by "and"
- **Italicized words in title** (e.g. species names) → also use `\ti{}`
- **Key** → `refN` where N is the next integer after the highest existing `\bibitem` key in main.tex

## Example (from main.tex)

```
\bibitem{ref1}Maia M. Cherney, Leonid T. Cherney I, Craig R. Garen and Michael N.G. James, The Structures of \ti{Thermoplasma volcanium} Phosphoribosyl Pyrophosphate Synthetase Bound to Ribose-5-Phosphate and ATP Analogs, \ti{J. Mol. Boil.}, \ti{\tb{413}}, 844-856 (2011)
```

## Workflow

1. **Read main.tex** to find all existing `\bibitem` entries and determine the next key number N.

2. **Gather paper info** — if the user has already provided the details (or a full citation string / DOI), parse them directly. Otherwise ask for: authors, title, journal, volume, pages, year.  
   - If a DOI is given, note that you cannot fetch web content, so ask the user to paste the citation details instead.

3. **Format the entry** following the rules above. Double-check:
   - Is the journal name inside `\ti{}`?
   - Is the volume inside `\ti{\tb{}}`?
   - Are any species names or other italicized words in the title also wrapped in `\ti{}`?
   - Does the year have parentheses and no trailing period?

4. **Insert** the new `\bibitem` line into main.tex, immediately after the last existing `\bibitem` line inside `\begin{thebibliography}...\end{thebibliography}`.

5. **Show the inserted line** to the user so they can verify it looks correct.

## Language policy

Respond in Japanese throughout.
