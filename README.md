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
Build command: pwd && ls && which python && cd /opt/buildhome/repo/ && . /opt/buildhome/repo/cloudflare.sh
Build output directory: /output
Build system version: 3 (latest)
Root directory: /
Environment variables: None
```

`cloudflare.sh` keeps that sourced entrypoint, assumes the build command has already `cd`'d into the repo root, prints extra shell diagnostics, bootstraps `uv` with `pip --user` if needed, runs `uv sync`, and then builds with `uv run pelican`.

Production builds use [publishconf.py](publishconf.py) via [cloudflare.sh](cloudflare.sh), so generated URLs, feeds, sitemap output, and output cleanup still use production settings without changing the Cloudflare Pages contract.

## Past challenges with cloudflare

I really can't tell what is going on, but it acts like there are 2 venvs on the machine and neither of them have
commands registered (e.g. `pelican`) until you activate the right environment and call `pelican` from the right one.
