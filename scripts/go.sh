#!/usr/bin/env bash
export THEME=themes/pelican-hyde
poetry run pelican content -s pelicanconf.py -t $THEME
start output/index.html
