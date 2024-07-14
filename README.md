# Blog

Matt's Pelican-based Life Blog.

## Installation

git clone.

```bash
poetry install --with dev
```

## Usage

Add files in `content`

To lint and build output.

```bash
./build.sh
```

Get whiny, unfixable complaints.

```bash
./reports.sh
```

Remote deployment on Cloudflare Pages.

```bash
./cloudflare.sh
```

## Hosting

I'm using [Cloudflare Pages](https://pages.cloudflare.com/) for my hosting because as
far as I can tell, it is free and it was easy enough to repoint my domain at it.

These are the build settings I use. Initially Cloudflare automatically configured it
with the wrong build command.

This worked a few times then stopped working

```text
Build command: /opt/buildhome/.local/bin/pelican content -s pelicanconf.py -t themes/pelican-hyde
Build output directory: /output
Root directory: /
Environment variables: None
```

Before the build command runs, it will detect Pipfile and try to run that.  It Can't install pipenv w/o lock file (runs pipenv in 2.7!!)

I since switched to poetry, not sure if the above is still true.

```bash
# Worked 1x, no longer
/opt/buildhome/.local/bin/pelican
# doesn't work
python -m pelican ...
# doesn't work
source /opt/buildhome/repo/.venv/bin/activate && /opt/buildhome/repo/.venv/bin/pelican content -s pelicanconf.py -t themes/pelican-hyde
```

Now using [cloudflare.sh](cloudflare.sh)

I really can't tell what is going on, but it acts like there are 2 venvs on the machine and neither of them have commands registered (e.g. `pelican`) until you activate the right environment and call `pelican` from the right one.
