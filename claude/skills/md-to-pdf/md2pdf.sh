#!/bin/bash
# Usage: ./md2pdf.sh file.md
#        ./md2pdf.sh *.md

if [ $# -eq 0 ]; then
  echo "Usage: $0 <file.md> [file2.md ...]"
  exit 1
fi

for file in "$@"; do
  if [ ! -f "$file" ]; then
    echo "Not found: $file"
    continue
  fi
  dir="$(dirname "$file")"
  base="$(basename "$file" .md)"
  dest_dir="$dir/claude-md2pdf"
  mkdir -p "$dest_dir"
  npx -y md-to-pdf "$file"
  mv "$dir/$base.pdf" "$dest_dir/$base.pdf"
  echo "Saved: $dest_dir/$base.pdf"
done
