#!/bin/bash

git2md . \
  --ignore __pycache__ uv.lock cloudflare.sh \
  .gitignore .markdownlintrc .pre-commit-config.yaml LICENSE \
  content draft \
  output \
  SOURCE.md \
  scripts \
  --output SOURCE.md

