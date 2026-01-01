Title: Taking control of my social media use
Date: 2026-01-01
Modified: 2026-01-01
Tags: social-media
Category: devlog
Slug: taking-control-of-my-social-media-use
Authors: Matthew Martin
Summary: Can I get rid of algorithmic feeds?

## Establishing the problem

Social media is a double-edged sword. I enjoy the human contact that I would otherwise miss, given that I work from
home as an IT worker.

On the other hand, my time tracker say that I routinely burn 10-20 hours on social media, the bulk of that time spent
scrolling, which is bad for my mood in addition to squeezing out other more valuable activities out of my day.

- Wake up scrolling.
- Twinge of boredom scrolling. This is the worst, it kicks me out of whatever I was doing.
- Waiting for something scrolling. In IT work, waiting is pretty common.

On the other hand, sometimes it isn't bad, some pro-social events that happen

- I post a thought that gets some feedback.
- I find a post that I can usefully contribute to

## Establishing the solution

Obviously, the solution is to write more code.

### A feed of people

First, the feed could be a feed of people, not the infinite scroll. This is the most difficult part to fix. A feed of
people is a newsfeed where the content is news about those people, especially mutuals or people that ever comment on
your posts. This would be a feed where each person shows once, retweets are absent, non-mutuals are de-emphasized, posts
of, say newspaper articles are de-emphasized.

The number of people you follow stay the same, the number of people who posted in the last 24 hours is finite. This feed
should be something that could be consumed in finite time, has a stopping point.

### Content curated by friends

There used to be a Twitter client that downloaded all your friends posts and created a whole new browsing experience.
Some of the tabs (deemphasized ones) in twitter also gave you a new experience, e.g. the media tab turned twitter into
a photo website, or a YouTube site with content made or curated by your friends.

This could work for a variety of content types

- A news tab
- A books tab
- A Github repos tab
- Best finds tab (e.g. all your friends retweets)

I'm of two minds about how the curated content tabs should work. Twitter, et al, want to increase your minutes spent on
the site, so twitter cards and content is brought into your feed. But I think these tabs should be launching points,
kind of like how google use to be your front door to the web that took you places.

### First draft

Anyhow, this is my first draft, "
Mastohuman" [https://github.com/matthewdeanmartin/mastohuman](https://github.com/matthewdeanmartin/mastohuman)

I don't like the name and the LLM didn't really get my vision. But that's not the point of this blog post, I'm thinking
aloud about what the final product should look like.

But I like the trajectory of this project and if I could switch to a "finite feed", that would really improve my quality
of life.