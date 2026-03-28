#!/bin/sh
set -eu

if [ ! -f pyproject.toml ]; then
    echo "cloudflare.sh expects to run from the repository root." >&2
    return 1 2>/dev/null || exit 1
fi

log() {
    printf '%s\n' "[cloudflare] $*"
}

run() {
    log "+ $*"
    "$@"
}

log "starting build"
log "pwd=$(pwd)"
log "PATH=$PATH"
run ls
run command -v python
run python --version
run sh --version || true
run command -v pip || true
run python -m pip --version
run command -v uv || true
run command -v pelican || true

log "python environment"
python - <<'PY'
import os
import site
import sys

print(f"executable={sys.executable}")
print(f"version={sys.version}")
print(f"prefix={sys.prefix}")
print(f"cwd={os.getcwd()}")
print(f"user_base={site.USER_BASE}")
print(f"user_site={site.getusersitepackages()}")
PY

if ! command -v uv >/dev/null 2>&1; then
    log "uv not found; installing with pip --user"
    run python -m pip install --user uv
    export PATH="$HOME/.local/bin:$PATH"
fi

run command -v uv
run uv --version

if [ -f uv.lock ]; then
    log "syncing dependencies from uv.lock"
    run uv sync --frozen
else
    log "uv.lock not found; resolving from pyproject.toml"
    run uv sync
fi

log "verifying pelican in uv environment"
run uv run pelican --version
run uv run python -c "import pelican, sys; print('pelican_module=' + pelican.__file__); print('python=' + sys.executable)"

log "building production site"
run uv run pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
