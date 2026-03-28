#!/bin/sh
set -e

cd "$(dirname "$0")"

echo "Gather Info"
command -v python
python --version
command -v poetry || true
command -v pelican || true
echo

if command -v poetry >/dev/null 2>&1; then
    poetry run pelican --version
    poetry run pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
elif command -v pelican >/dev/null 2>&1; then
    pelican --version
    pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
else
    python -m pelican --version
    python -m pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
fi
