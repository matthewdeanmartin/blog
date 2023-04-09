Title: Running, OpenAI Side Project, Shells
Date: 2023-02-12
Modified: 2023-02-12
Tags: life
Category: life
Slug: running-openai-side-project-shells
Authors: Matthew Martin
Summary: I'm training for another half-marathon, learning prompt engineering and trying to switch to fish.

## Running

Last December, I ran my 1/2 marathon, got a mild case of extensor tendonitis (self diagnosed) and then the holidays and side projects took over. So I ran between 5 and 7 miles per week most weeks. This week I'm back to 21+ miles per week.

I got a half-marathon coming up fast, in 7 weeks, so I figure I need to ramp up to 6 miles a day. That means the running I do over the next 3 weeks has the most impact, if it takes 4 weeks for training to have an impact. Last time I did a surge of training, I did daily split sessions and strength training most days.

## Side Projects

My most successful side project has been [cheaper_openai](https://github.com/matthewdeanmartin/cheaper_openai) which I created when I heard they might charge $42 a month. The lower price came out and I cancelled my satellite radio and signed up. Which should you use? Assistant (ChatGPT) is for hard questions, coding. Davinci is for experiments where:

- having a machine make many similar request would help, e.g. trying to get a funny joke
- having code compile the response would help, e.g. book writing
- the response is machine-readable, e.g. generating json, yaml, etc

Otherwise, most of the time, Assistant is smarter.

## The rabbit-hole of shells

The `sh` and `bash` shell are both annoying, brain-damaged programming languages. I tried to get Davinci to generate a whole book on `fish` and `powershell` shell programming as well as how to do shell-programming-like tasks using `python` with mixed results.

Optimal shell workflow (which I haven't achieved myself)

- fish for a daily driver
- python for anything not mostly just calling other commands (i.e. not 90% subprocess code)
- powershell for anything windows specific or where the code for some reason needs to be shell
- bash for esperanto of scripts, but with none of esperanto's charm or personality

Short story, I think I'm going to try to make fish my default shell.
