Title: Meta and stuff
Date: 2023-01-15
Modified: 2023-01-15
Tags: life
Category: life
Slug: chatgpt-markdown-running-jan-15
Authors: Matthew Martin
Summary: Whatever man, I don't know.

## Telling Assistant to translate python code to Go

Yesterday was spent hacking on ChatGPT. I almost got it to convert pymarc to golang. The key is to strip down the source code to the bare bones so that it can fit into Assistants memory.

I tried [python-minifier](https://github.com/dflook/python-minifier) but that didn't really help, I think it made it worse by nearly obfuscating some code. If I can't read it, Assistant probably can't either. I think it just needs comments and docstrings stripped out. Assistant really also can only see things as one document, so if you got 10 files, it needs them merged to one, in an order than tells a story.

## Chasing Markdown down a rabbit hole

A while ago I tried to create a markdown build script. Markdown is such a weird thing. It is English, so it needs spellcheck, grammar check. It is a templating language so it can benefit from linting. It also an input to a lot of CMS's that all did different things to handle Markdowns limitations.

Here is what I made:

- [A build script](https://github.com/matthewdeanmartin/blog/blob/main/build.sh)
- [A pre-commit script](https://github.com/matthewdeanmartin/blog/blob/main/.pre-commit-config.yaml)

I also had the pre-commit hook call the build script adn the build commit call `pre-commit run` and wondered why it took forever.

## Running

Also ran on the treadmill. With November, December, and January being an endless collage of some sort of common code, I'm still not at 100% like I was in the autumn.

Kids went to swimming lessons yesterday, so not a lot of activies. I'm trying to catch up on that today.
