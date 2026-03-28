#!/usr/bin/env bash
set -euo pipefail

echo "Gather Info"
command -v python
python --version
command -v uv
echo
command -v pip || true
python -m pip --version
python -m pip freeze
echo
# not used later on...
#pip install pipenv poetry
command -v pipenv || true
command -v poetry || true
echo
echo "Activate"
echo
# . /opt/buildhome/repo/.venv/bin/activate
echo
echo "Did we activate?"
echo
uv run python -m pip --version
uv run python -m pip freeze
echo
echo "Summon the pelican!!!"
echo
#/opt/buildhome/repo/.venv/bin/pelican --version
#/opt/buildhome/repo/.venv/bin/pelican content -s pelicanconf.py -t themes/pelican-hyde

uv run pelican --version
uv run pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors


# Get the Bash version
echo "Bash Version:"
bash --version | head -n 1

# Get Linux distribution and version
echo -e "\nLinux Distribution and Version:"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$NAME $VERSION"
else
    echo "OS information not found."
fi

# Get Kernel version
echo -e "\nKernel Version:"
uname -r

# Get system architecture
echo -e "\nSystem Architecture:"
uname -m

# Get hostname
echo -e "\nHostname:"
hostname

# Get uptime
echo -e "\nSystem Uptime:"
uptime -p

# Get current user
echo -e "\nCurrent User:"
whoami

# Get total memory
echo -e "\nTotal Memory:"
grep MemTotal /proc/meminfo

# Get disk usage
echo -e "\nDisk Usage:"
df -h /

# Get IP address
echo -e "\nIP Address:"
hostname -I | awk '{print $1}'

echo -e "\nSystem information gathered successfully."
