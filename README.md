# blog

pelican blog

# installation

git clone.

```bash
pipenv install --dev --skip-lock
```

# usage

Add files in `content`

TODO: run markdown_build to verify text.

# Hosting

I'm using [Cloudflare Pages](https://pages.cloudflare.com/) for my hosting because as
far as I can tell, it is free and it was easy enough to repoint my domain at it.

These are the build settings I use. Initially Cloudflare automatically configured it
with the wrong build command.

```
Build command: /opt/buildhome/.local/bin/pelican content -s pelicanconf.py -t themes/pelican-hyde
Build output directory: /output
Root directory: /
Environment variables: None
```
