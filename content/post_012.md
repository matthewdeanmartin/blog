Title: Creating a Portfolio Website
Date: 2025-12-20
Modified: 2025-12-20
Tags: programming
Category: programming
Slug: creating-a-portfolio-website
Authors: Matthew Martin
Summary: Creating a Portfolio Website

## How many ways to create a home page?

I think people (like me) might want to have a personal website for 3 reasons:

- Job hunting. "I need a job, you need a "
- An Identity site. "This is who I am"
- Project promotion. "Look at this thing I did."

As of today, I don't need a job, but when I do, these are the features I wish my website had:

- Easy way to list my resumes
- Easy way to let a technical hiring manager go from a skill claim directly to a portfolio repo demonstrating that
- A way to quickly recombine the parts of my resume to create new job requisition specific resumes

I also wish that all the various ways to repackage the data about me could be auto-updated.

So I've been coding, with LLM help, most of the above.

## The Perfect Readme

Github has a special readme that shows top-of-page on your profile page.

My perfect profile readme has all the information about me. That is more than fits on a screen, so
I've swung towards a much shorter and depend on mode (job hunting, identity, project-promotion), switches from longer to
shorter.

When complete, I plan to have most of the information available on markdown links from the compact
front page. I don't expect people to browse those much, so I got an HTML site, too.

Github gives you a primary URL and I've pointed that to the HTML version, with

- Resume looking thing
- Grouped project list
- A static Swagger API, because why not. I was thinking of using this as a datasource for an angular website.

## Taxonomy is pain

The biggest challenge is just managing the data and cleaning it up.

- Projects need to be grouped, tagged
- Dead projects need to be deleted, archived, hidden.

Tagging is a particular pain. There are at least 3+ ways projects need to be categorized

- Github's tags, so github searchers can find my repo or more likely, as a hint to what the repo is about
- pypi's tags, so package searcher can find my packages
- related to a skill
- Language which sometimes is a skill and sometimes it is noise in the tags
- relevant to a job hunt
- quality- is it awesome or not worth looking at because it is too new, too old, etc.

## Dreams of publishing this

It is on my wishlist to make this generic enough to publish on pypi.

It will probably end up being github centric and python centric because of the pypi integration.

