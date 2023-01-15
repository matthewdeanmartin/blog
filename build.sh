#!/bin/bash
# set -euxo pipefail
bash --version

# Set tool locations
TIDY="node_modules/.bin/tidy-markdown"

echo "Working with these files"
FILES=$(find . -type f -name "*.md" ! -path "./node_modules/*")
for file in $FILES; do
    echo "$file"
done
echo

echo
echo "Formatting markdown files with mdformat"
echo
find . -type f -name "*.md" ! -path "./node_modules/*" | xargs mdformat

echo
echo "Are the links okay?"
echo
linkcheckMarkdown content

echo
echo "Precommit"
echo
pre-commit run --all-files

echo
echo "Does pelican like it?"
echo 
pelican content -s pelicanconf.py -t themes/pelican-hyde
