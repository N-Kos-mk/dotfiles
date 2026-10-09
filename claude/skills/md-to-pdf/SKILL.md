---
name: md-to-pdf
description: Convert Markdown files to PDF. Use this skill whenever the user says things like 「hoge.mdをpdfにして」「このmdをpdfに変換して」「mdをpdfに」「pdfに変換して」or asks to convert any markdown file to PDF in any phrasing.
---

Convert the specified Markdown file(s) to PDF using the bundled script.

## Script location

`md2pdf.sh`, bundled in this skill's own directory (same directory as this SKILL.md).
The invocation context reports this directory as "Base directory for this skill: <dir>" — use that `<dir>` in place of the placeholder below rather than hardcoding a machine-specific path.

## Workflow

1. Identify the target file(s) from the user's message or IDE open-file context
2. If no file is specified, ask the user which file to convert
3. Verify the file exists
4. Run the script, using the skill's base directory from the invocation context:
   ```bash
   bash "<skill-base-dir>/md2pdf.sh" "<absolute-path-to-file.md>"
   ```
5. Report success in Japanese, showing the output PDF path

## Notes

- Output PDF is saved to `claude-md2pdf/` in the same directory as the source MD file
- Multiple files can be passed as separate arguments
- The script uses `npx md-to-pdf` internally; first run may take a moment to install

## Response language

Always respond in Japanese.
