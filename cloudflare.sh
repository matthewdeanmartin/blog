#!/usr/bin/env bash
set -eo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

echo "Gather Info"
command -v python
python --version
command -v uv || true
echo
command -v pip || true
python -m pip --version
python -m pip freeze
echo
command -v pipenv || true
command -v poetry || true
echo

if [ -f "$REPO_ROOT/.venv/bin/activate" ]; then
    echo "Activating local virtualenv"
    # Cloudflare Pages may need the repo-local venv to expose pelican reliably.
    . "$REPO_ROOT/.venv/bin/activate"
    echo
fi

echo "Summon the pelican!!!"
echo

if command -v uv >/dev/null 2>&1; then
    uv run pelican --version
    uv run pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
elif command -v poetry >/dev/null 2>&1; then
    poetry run pelican --version
    poetry run pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
elif command -v pelican >/dev/null 2>&1; then
    pelican --version
    pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
else
    python -m pelican --version
    python -m pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
fi


# Get the Bash version
echo "Bash Version:"
bash --version | head -n 1

print_if_available() {
    local label="$1"
    shift
    echo -e "\n${label}:"
    if command -v "$1" >/dev/null 2>&1; then
        "$@"
    else
        echo "$1 not available."
    fi
}

# Get Linux distribution and version
echo -e "\nLinux Distribution and Version:"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$NAME $VERSION"
else
    echo "OS information not found."
fi

print_if_available "Kernel Version" uname -r
print_if_available "System Architecture" uname -m
print_if_available "Hostname" hostname
print_if_available "System Uptime" uptime -p
print_if_available "Current User" whoami

echo -e "\nTotal Memory:"
if [ -f /proc/meminfo ]; then
    grep MemTotal /proc/meminfo
else
    echo "/proc/meminfo not available."
fi

print_if_available "Disk Usage" df -h /

echo -e "\nIP Address:"
if command -v hostname >/dev/null 2>&1 && hostname -I >/dev/null 2>&1; then
    hostname -I 2>/dev/null | awk '{print $1}'
else
    echo "hostname -I not available."
fi

echo -e "\nSystem information gathered successfully."
