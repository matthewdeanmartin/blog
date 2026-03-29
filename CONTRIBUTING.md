# Contributing

This repository is a Pelican-based static blog with a few deployment quirks that are worth understanding before you change anything.

## High-level rules

- Use `uv` for local Python workflows.
- Keep Cloudflare deployment compatible with the existing sourced shell command.
- Treat this repository as a content/build repo, not as a normal Python package with importable modules.
- Preserve the distinction between development config (`pelicanconf.py`) and production config (`publishconf.py`).

## Local development

Install dependencies with:

```bash
uv sync
```

Common commands:

```bash
make build
make check
make clean
make deploy
```

What those do:

- `make build` runs `scripts/go.sh`, which builds the site with `uv run pelican ... --fatal errors`.
- `make check` runs `scripts/reports.sh`.
- `make clean` removes `output/`.
- `make deploy` runs `cloudflare.sh`.

## Pelican configuration

`pelicanconf.py` is the base config. It intentionally includes:

- `SITEURL = "https://blog.wakayos.com"`
- `TIMEZONE = "America/New_York"`
- feed generation for both Atom and RSS
- `STATIC_PATHS` for `images` and `extra`
- sitemap plugin configuration
- `FAVICON = "favicon.svg"`

`publishconf.py` imports from `pelicanconf.py` and overrides production-only behavior:

- `RELATIVE_URLS = False`
- `DELETE_OUTPUT_DIRECTORY = True`

Do not collapse these files back into one config unless you are also rethinking the production build flow.

## Static assets

Static extras live under `content\extra`.

Currently expected:

- `content\extra\robots.txt`
- `content\extra\favicon.svg`

These are mapped via `EXTRA_PATH_METADATA` so they land at the output root as:

- `output\robots.txt`
- `output\favicon.svg`

## Cloudflare Pages deployment

The current Cloudflare Pages build command is intentionally:

```text
pwd && ls && which python && cd /opt/buildhome/repo/ && . /opt/buildhome/repo/cloudflare.sh
```

Important implications:

- `cloudflare.sh` is **sourced**, not executed.
- Cloudflare may use `/bin/sh`, not Bash.
- The script must remain POSIX `sh` compatible.
- The script must assume the build command already changed into the repo root.

Because of that, avoid Bash-only features in `cloudflare.sh`, including:

- `set -o pipefail`
- `BASH_SOURCE`
- `local`
- arrays
- `[[ ... ]]`
- other Bash-specific syntax

The script currently:

- verifies it is running from the repo root
- prints diagnostics (`pwd`, `PATH`, tool locations, Python details)
- installs `uv` with `python -m pip install --user uv` if needed
- runs `uv sync` (preferring `uv.lock` with `--frozen`)
- runs the production Pelican build with `publishconf.py`

If you change `cloudflare.sh`, validate both of these patterns locally:

```bash
sh -c '. ./cloudflare.sh'
```

and

```bash
./cloudflare.sh
```

When testing the sourced form, first `cd` into the repo root.

## Why `pyproject.toml` looks unusual

Cloudflare auto-detects Python tooling before your build command runs.

We learned the following:

- If `[tool.poetry]` exists, Cloudflare may run `poetry install`.
- If Poetry metadata is removed, Cloudflare may fall back to `pip install .`.
- A plain setuptools build will try to auto-discover packages in this repo and fail, because directories like `content`, `themes`, `draft`, and `spec` are not Python packages we want to distribute.

That is why `pyproject.toml` now includes:

- `[tool.uv] package = false`
- a setuptools build backend
- `[tool.setuptools] py-modules = []`

That combination allows:

- `pip install .` to succeed during Cloudflare bootstrap
- `uv sync` to remain the real environment manager
- the repo to avoid accidental package discovery

Do not reintroduce Poetry metadata unless you intentionally want Cloudflare to switch back to `poetry install`.

## Validation checklist for changes

If you touch build, deployment, or config code, run as many of these as are relevant:

```bash
python -m pip install .
uv sync
make clean
make build
uv run pelican content -s publishconf.py -t themes/pelican-hyde --fatal errors
sh -c '. ./cloudflare.sh'
```

Expected production artifacts include:

- `output\feeds\all.atom.xml`
- `output\feeds\all.rss.xml`
- `output\robots.txt`
- `output\favicon.svg`
- `output\sitemap.xml`

## Notes on `make check`

`make check` uses the existing repository QA script and may fail on prose lint warnings in documentation files that are unrelated to your change.

If it fails:

- read the actual warning text
- distinguish between pre-existing docs/prose issues and build regressions
- fix the issue if your change introduced it

Do not assume a failing prose checker means the Pelican or Cloudflare build is broken.

## Content and drafts

- Published content lives in `content`.
- Drafts live in `draft`.
- Build and link-check flows should stay scoped to published content unless there is a deliberate reason to include drafts.

## Licensing

Project metadata says:

```toml
license = { text = "All rights reserved." }
```

Keep that intact unless the owner explicitly changes the repository license.

Also note: the bundled third-party theme contains its own upstream license files. Do not rewrite third-party license notices just because the blog content itself is all rights reserved.
