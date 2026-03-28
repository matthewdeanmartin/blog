#!/usr/bin/env bash
set -euo pipefail

export THEME=themes/pelican-hyde
uv run pelican content -s pelicanconf.py -t "$THEME" --fatal errors
