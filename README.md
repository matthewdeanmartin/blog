# Blog

Matt's Pelican-based Life Blog.

## Installation

git clone.

```bash
uv sync
```

## Usage

Add files in `content`

Build it!

```bash
make build
```

Run checks:

```bash
make check
```

Clean generated output:

```bash
make clean
```

Remote deployment on Cloudflare Pages.

```bash
make deploy
```

## Hosting

I'm using [Cloudflare Pages](https://pages.cloudflare.com/) for my hosting because as far as I can tell, it is free, and
it was easy enough to repoint my domain at it.

```text
Build command: /opt/buildhome/.local/bin/pelican content -s pelicanconf.py -t themes/pelican-hyde
Build output directory: /output
Root directory: /
Environment variables: None
```

Maybe this?
```text
Build command: ./cloudflare.sh
Build output directory: /output
Root directory: /
Environment variables: None
```

Use the latest Cloudflare Pages build config and make sure `uv` is available in the build environment, since both local and production builds now run through `uv`.

Production builds use [publishconf.py](publishconf.py) via [cloudflare.sh](cloudflare.sh), so generated URLs, feeds, sitemap output, and output cleanup use production settings.

## Past challenges with cloudflare

I really can't tell what is going on, but it acts like there are 2 venvs on the machine and neither of them have
commands registered (e.g. `pelican`) until you activate the right environment and call `pelican` from the right one.
