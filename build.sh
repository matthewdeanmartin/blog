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

# Format the markdown files
# skip node_modules
echo "Formatting markdown files with mdformat"
find . -type f -name "*.md" ! -path "./node_modules/*" | xargs mdformat
