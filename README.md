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

Remote deployment on Cloudflare Pages.

```bash
./cloudflare.sh
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

Use the latest Cloudflare pages build config, version 3 at my time of writing. It does not have uv installed by default.

Now using [cloudflare.sh](cloudflare.sh)

## Past challenges with cloudflare

I really can't tell what is going on, but it acts like there are 2 venvs on the machine and neither of them have
commands registered (e.g. `pelican`) until you activate the right environment and call `pelican` from the right one.
