#!/usr/bin/env bash
set -euo pipefail
bash --version

echo "Working with these files"
FILES=$(find ./content -type f -name "*.md")
for file in $FILES; do
    echo "$file"
done
echo

echo
echo "Formatting markdown files with mdformat"
echo
for file in $FILES; do
    mdformat "$file"
done


echo
echo "Are the links okay?"
echo
linkcheckMarkdown content

#echo
#echo "Precommit"
#echo
# pre-commit run --all-files

echo
echo "Does pelican like it?"
echo 
uv run pelican content -s pelicanconf.py -t themes/pelican-hyde --fatal errors
