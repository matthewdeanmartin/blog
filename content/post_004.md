Title: Side projects
Date: 2023-01-21
Modified: 2023-01-21
Tags: life
Category: life
Slug: docker-on-gitlab-polyrepos-chatgpt
Authors: Matthew Martin
Summary: Github and ChatGPT experiments, learning about mono and polyrepos

## Migrating my docker images to github.

I find Github's pricing guidance bemusing, but it looks like I can host more public images on Github than I can on Dockerhub (many more than 1 vs 1). The limits are on bandwidth per month (1GB) with no obvious guidance on how that is calculated.

Anyhow, [my Stackoverflow novelty build tool and my text editor novelty are both available prebuilt](https://github.com/matthewdeanmartin?tab=packages).

The most challenging part was learning about Github secrets.

- I used a recommended workflow file that logs into Dockerhub and Gitlab
- I had to realize GITLAB_TOKEN is automatically available and I don't have to create such a secret.
- I had to create an environment
- Set that environment to "all branches"
- I had to edit the workflow file to explicitly name a `environment: NAME_OF_MY_ENVIRONMENT`

Next I guess I will experiment with pex/shiv and other ways to package a

## Monorepo and polyrepo build strategies

I just started looking at this stuff. They both appear to be alternate ways to deal with dependency hell. If you read up on the sort of solutions for monorepos, you get ideas for doing the same thing with polyrepos, e.g. builds that trigger builds in other repos, making changes to many repos at the same time as a sort of "transaction".

So far, I've found tools like `gita` which run the same git command against many local repos. The build server part depends on your host, but API for github, gitlab, etc, would simulate the build-script-of-build-scripts. Anyhow, cool stuff.

## Playing Toca Boca on ChatGPT

My 6-year-old daughter and I have been playing Toca Boca with ChatGPT. It is difficult. You prompt needs to:

- Get it to stop saying, "Oh, I'm just a model, I can't do anything"
- Get it to stop saying, "Oh, I'm just a model, I have no wants"

If you tell it to write at a 6-year-old's level that helps.

Another challenge is that Assistant can't cope with arbitrarily messed up English. Humans can just sound out a 1st grader's text and get it, but Assistant just can't cope. It isn't sounding out word, it can't hear.
