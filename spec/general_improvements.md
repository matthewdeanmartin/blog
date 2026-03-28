# Blog General Improvements Plan

Generated: 2026-03-28

---

## 1. Pelican Features Not Being Used

### 1.1 No `publishconf.py` (separate prod config)

**Problem:** `pelicanconf.py` has `RELATIVE_URLS = True` and `SITEURL = 'http://...'`. Pelican's convention is a `publishconf.py` that imports from `pelicanconf.py` and overrides settings for production (absolute URLs, no relative URLs, feed settings). Currently the site is always built with relative URLs, which means the RSS feeds will have broken links in production.

**Fix:** Create `publishconf.py`:
```python
from pelicanconf import *

SITEURL = 'https://blog.wakayos.com'   # note https
RELATIVE_URLS = False
FEED_ALL_ATOM = 'feeds/all.atom.xml'
FEED_ALL_RSS = 'feeds/all.rss.xml'
DELETE_OUTPUT_DIRECTORY = True
```

Update `cloudflare.sh` to use `-s publishconf.py` for production builds.

### 1.2 `SITEURL` uses HTTP not HTTPS

**Problem:** `SITEURL = 'http://blog.wakayos.com'` — Cloudflare Pages serves over HTTPS. This means canonical links, Open Graph URLs, and feed links all have wrong scheme.

**Fix:** Change to `https://blog.wakayos.com` in both `pelicanconf.py` and new `publishconf.py`.

### 1.3 `TIMEZONE` is set to "EST" (invalid)

**Problem:** `TIMEZONE = "EST"` is not a valid IANA timezone. Python's `zoneinfo` (and `pytz`) do not recognize bare "EST". The correct value is `"America/New_York"`.
This can cause incorrect article timestamps and warnings from Pelican.

**Fix:** Change to `TIMEZONE = "America/New_York"`.

### 1.4 `STATIC_PATHS` not configured

**Problem:** The `STATIC_PATHS` and `EXTRA_PATH_METADATA` block is commented out. Without `STATIC_PATHS = ['images']`, Pelican may not reliably copy the images directory to output. It works incidentally because images are referenced from content, but this is fragile.

**Fix:** Uncomment and configure:
```python
STATIC_PATHS = ['images', 'extra']
EXTRA_PATH_METADATA = {
    'extra/robots.txt': {'path': 'robots.txt'},
    'extra/favicon.ico': {'path': 'favicon.ico'},
}
```
Also create `content/extra/robots.txt` with basic content.

### 1.5 Atom feeds not configured

**Problem:** Only RSS feeds are configured (`FEED_ALL_RSS`, `CATEGORY_FEED_RSS`). Pelican supports Atom feeds natively (`FEED_ALL_ATOM`, `CATEGORY_FEED_ATOM`), which are preferred by many feed readers and aggregators. The theme's `feeds.html` fragment likely supports both.

**Fix:** Add to `pelicanconf.py` (dev) and `publishconf.py` (prod):
```python
FEED_ALL_ATOM = 'feeds/all.atom.xml'
CATEGORY_FEED_ATOM = 'feeds/{slug}.atom.xml'
```

### 1.6 `PYGMENTS_RST_OPTIONS` used but content is Markdown

**Problem:** `PYGMENTS_RST_OPTIONS = {'linenos': 'table'}` only applies to RST documents. Since `READERS = {'html': None}` and all content is Markdown, this setting has no effect. Syntax highlighting line numbers for Markdown code blocks are controlled differently.

**Fix (option A):** Remove the dead config line.
**Fix (option B):** Add `MARKDOWN` extension config to enable line numbers for Markdown code blocks:
```python
MARKDOWN = {
    'extension_configs': {
        'markdown.extensions.codehilite': {
            'css_class': 'highlight',
            'linenums': False,   # or True if you want line numbers
        },
        'markdown.extensions.extra': {},
        'markdown.extensions.meta': {},
    },
    'output_format': 'html5',
}
```

### 1.7 `DEVOPS_LINKS` is an unused custom variable

**Problem:** `DEVOPS_LINKS = (('', ''),)` is defined but never used in any template. It's dead config.

**Fix:** Remove it, or use it — add a "DevOps Links" section to the sidebar template if there are links worth sharing.

### 1.8 `LINKS` is empty / all commented out

**Problem:** `LINKS = ()` with all blogroll links commented out. The sidebar template almost certainly has a block to render `LINKS`. Either the links are useful and should be shown, or the template block should be removed.

**Fix (option A):** Restore some links from the commented list.
**Fix (option B):** Leave empty but remove the dead commented-out links to reduce noise.

### 1.9 No `robots.txt` or `favicon.ico`

**Problem:** No `robots.txt` in output means crawlers get the default "allow all" (fine) but there's no `Sitemap:` directive pointing to the sitemap. No favicon means browsers show a broken icon.

**Fix:** Add `content/extra/robots.txt`:
```
User-agent: *
Disallow:
Sitemap: https://blog.wakayos.com/sitemap.xml
```
Add a `favicon.ico` or `favicon.png` to `content/extra/`.
Update `STATIC_PATHS` and `EXTRA_PATH_METADATA` as in 1.4.

### 1.10 Pelican sitemap plugin not enabled

**Problem:** Pelican has a built-in `sitemap` plugin (part of `pelican-plugins` or the standalone `pelican-sitemap` package) that generates `sitemap.xml`. This helps search engines crawl the blog. Currently not configured.

**Fix:** Add `pelican-sitemap` to `pyproject.toml` and configure:
```python
PLUGINS = ['sitemap']
SITEMAP = {
    'format': 'xml',
    'priorities': {
        'articles': 0.5,
        'indexes': 0.5,
        'pages': 0.5
    },
    'changefreqs': {
        'articles': 'monthly',
        'indexes': 'daily',
        'pages': 'monthly'
    }
}
```

### 1.11 `GOOGLE_ANALYTICS` template fragment exists but is unused

**Problem:** `themes/pelican-hyde/templates/fragments/google_analytics.html` exists but is presumably not included anywhere (the site has no `GOOGLE_ANALYTICS` setting). This is dead template code.

**Fix:** Either configure it with a GA4 measurement ID, or delete the fragment if not needed.

---

## 2. Makefile / Scripts — QA Checks to Add

### 2.1 No `check` / `lint` target in Makefile

**Problem:** `scripts/reports.sh` exists with alex, markdownlint, linkcheckMarkdown, proselint, and write-good, but the Makefile has no target to invoke it. Running QA requires knowing about the script directly.

**Fix:** Add to `Makefile`:
```makefile
check:
	./scripts/reports.sh

report: check
```

### 2.2 `build.sh` uses `poetry run` but `go.sh` uses `uv run` — inconsistent

**Problem:** `scripts/build.sh` uses `poetry run pelican ...` and `poetry run mdformat ...` but `scripts/go.sh` (the current primary build script) uses `uv run pelican ...`. They're not in sync. `build.sh` likely fails if poetry is not installed.

**Fix:** Update `build.sh` to use `uv run` consistently (matching `go.sh`), or delete `build.sh` since its functionality is covered by the Makefile targets.

### 2.3 `build.sh` searches ALL `.md` files including `draft/`

**Problem:** `find . -type f -name "*.md" ! -path "./node_modules/*"` in `build.sh` picks up draft files. This means `mdformat` reformats drafts (fine) but `linkcheckMarkdown` checks links in drafts that may intentionally have placeholder or broken links.

**Fix:** Narrow the find to `./content` only for link checks, matching what `go.sh` builds:
```bash
CONTENT_FILES=$(find ./content -type f -name "*.md")
```

### 2.4 `reports.sh` runs `set -euo pipefail` *after* the first commands

**Problem:** Lines 1-15 of `reports.sh` run before `set -euo pipefail` on line 21. If `find` or the echo loop fails, there's no early exit. `set -euo pipefail` should be at the top.

**Fix:** Move `set -euo pipefail` to line 3 (right after `#!/bin/bash`).

### 2.5 `reports.sh` uses `echo "$MARKDOWNLINT" ...` instead of running it

**Problem:** Line 23 does `echo "$MARKDOWNLINT" "$file" ...` which only prints the command, not runs it. Line 24 runs it correctly. The echo is redundant and misleading (looks like dry-run output).

**Fix:** Remove the spurious `echo` on line 23, or change it to `echo "Linting: $file"`.

### 2.6 No `make clean` target

**Problem:** The `output/` directory accumulates stale files when articles are renamed or deleted. Pelican has a `DELETE_OUTPUT_DIRECTORY` setting but it's not set. No `make clean` exists.

**Fix:** Add to `Makefile`:
```makefile
clean:
	rm -rf output/
```
And set `DELETE_OUTPUT_DIRECTORY = True` in `publishconf.py`.

### 2.7 `go.sh` uses `start` (Windows-only) to open browser

**Problem:** `start output/index.html` is a Windows shell command. This works locally but would fail if ever run on Linux (e.g., Cloudflare CI, WSL). It also means the build script has a side-effect (opening a browser) baked in, which is not appropriate for CI contexts.

**Fix (option A):** Remove the `start` line from `go.sh` and add a separate `open` target to the Makefile that works cross-platform.
**Fix (option B):** Guard it: `[[ "$OSTYPE" == "msys" ]] && start output/index.html || true`.

### 2.8 No `make deploy` or `make publish` target

**Problem:** Deployment is done via `cloudflare.sh` but there's no Makefile target for it. Adding it would make the workflow more discoverable.

**Fix:** Add to `Makefile`:
```makefile
deploy:
	./cloudflare.sh
```

### 2.9 `cloudflare.sh` still uses `poetry run` but project uses `uv`

**Problem:** `cloudflare.sh` uses `poetry run pelican ...` as the actual production build command. If Cloudflare's build environment doesn't have poetry, this fails. The project has migrated to `uv` in `go.sh`.

**Fix:** Check what Cloudflare Pages actually has available, and update `cloudflare.sh` to use `uv run pelican ...` with a fallback, or simply call `uv run pelican content -s publishconf.py -t themes/pelican-hyde`.

### 2.10 No Pelican `--fatal errors` flag in build scripts

**Problem:** Pelican by default continues building even with warnings (missing metadata, etc.). In CI, it's better to fail on errors. The `--fatal errors` flag makes Pelican exit non-zero on errors.

**Fix:** Add `--fatal errors` to the pelican invocation in `go.sh` and `cloudflare.sh`:
```bash
uv run pelican content -s pelicanconf.py -t $THEME --fatal errors
```

---

## 3. Orphaned / Misplaced File

### 3.1 `post_014_habit_math.md` in repo root

**Problem:** `/c/github/blog/post_014_habit_math.md` exists in the repo root, outside of `content/` or `draft/`. Pelican will not pick it up for building. It's either a draft that should be in `draft/` or an article that should be in `content/`.

**Fix:** Move to `draft/post_014_habit_math.md` or `content/` as appropriate.

---

## 4. Priority Order

| Priority | Item | Effort | Impact |
|----------|------|--------|--------|
| High | 1.2 Fix SITEURL to HTTPS | Trivial | SEO/security |
| High | 1.3 Fix TIMEZONE to valid IANA name | Trivial | Correctness |
| High | 2.4 Move `set -euo pipefail` to top of reports.sh | Trivial | Bug fix |
| High | 2.5 Remove spurious echo in reports.sh | Trivial | Bug fix |
| High | 3.1 Move orphaned root-level md file | Trivial | Cleanliness |
| Medium | 1.1 Add publishconf.py | Small | Correctness |
| Medium | 1.5 Add Atom feeds | Small | Discoverability |
| Medium | 1.4 Configure STATIC_PATHS | Small | Correctness |
| Medium | 1.6 Remove/fix PYGMENTS_RST_OPTIONS | Small | Cleanliness |
| Medium | 1.7 Remove dead DEVOPS_LINKS | Trivial | Cleanliness |
| Medium | 2.1 Add `make check` target | Trivial | DX |
| Medium | 2.2 Align build.sh to use uv | Small | Consistency |
| Medium | 2.3 Narrow find to content/ in build.sh | Small | Correctness |
| Medium | 2.6 Add `make clean` target | Trivial | DX |
| Medium | 2.7 Guard/remove `start` in go.sh | Trivial | Portability |
| Low | 1.8 Clean up LINKS comments | Trivial | Cleanliness |
| Low | 1.9 Add robots.txt + favicon | Medium | Polish |
| Low | 1.10 Add sitemap plugin | Medium | SEO |
| Low | 1.11 Remove/use GA template fragment | Trivial | Cleanliness |
| Low | 2.8 Add `make deploy` target | Trivial | DX |
| Low | 2.9 Update cloudflare.sh to use uv | Small | Correctness |
| Low | 2.10 Add --fatal errors to pelican | Trivial | CI quality |
| Low | 1.6b Configure MARKDOWN extensions | Small | Feature |
