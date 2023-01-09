#!/bin/bash
# set -euxo pipefail
bash --version

# Set tool locations
ALEX="./node_modules/.bin/alex"
MARKDOWNLINT="./node_modules/.bin/markdownlint"

echo "Working with these files"
FILES=$(find ./content -type f -name "*.md")
for file in $FILES; do
    echo "$file"
done
echo

echo "Linting markdown files with alex"
npx alex
# "$ALEx"

echo "Linting markdown files with markdownlint"
"$MARKDOWNLINT" ./**/*.md --ignore node_modules --ignore .git --ignore .idea

echo "Checking links in markdown files with linkcheckMarkdown"

for file in $FILES; do
    linkcheckMarkdown "$file"
done


echo "Checking with proselint"
for file in $FILES; do
    proselint "$file"
done

echo "Checking links in markdown files with write-good"
for file in $FILES; do
    npx write-good "$file"
done

# #$!@#$@#! useless right now
#echo "Checking spelling/grammar with ginger (remote API)"
#for file in $FILES; do
#    npx textlint --rule textlint-rule-ginger "$file"
#done

