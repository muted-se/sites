# Contributing #
## Introduction ##
Welcome dear Internet individual, you have arrived at the most remote and 
distant resource found; the `CONTRIBUTING.md` of my personal repositories.

That being said there are some rules that we all shall follow if collaborating:

- 📗 Use descriptive `commit comments` and `code comments`.
- 📗 Utilize the `Pull-Request` functionality (since you are forced to) and 
be brief but informative in the request.
- 📗 Behave as if everyone can see what you are doing (since they can).

## 📏 Pull-Requests ##
All collaborated code shall be approved before admitted via a `Pull-request` 
and is subject to scrutiny by the community and approval of the `grand-master`.

If providing changes please remember to;

- 📘 Have descriptive `commit messages`.
- 📘 Follow the standards of [Google](https://google.github.io/styleguide/shellguide.html).
- 📘 Use all suggested `linters`.
- 📘 Write code that is understandable.
- 📘 Upon request explain code and rewrite code according to instructions.
- 📘 Have proper comments inline when applicable.

Not all of the above will be applied to every request, since we are humans, but
can be used as guidelines to get a `fast-track` on any `Pull-Request`.

## 📏 Commit Messages ##
We utilize `squash merging` in this repository and as such the `commit message`
will be in the `commit history` forever. As such please remember to write 
proper commit messages with relevant information:

### Bad ###
```
git commit -m "Did some stuff"
```

### Good ###
```
git commit -m "Fixed #1 by using the correct syntax"
```

## 🌳 Branch names ##
This repository uses `branches` for automation as such the names are controlled
and a specific `regex` pattern is applied. So all branches must start with any
of the following:

- `feat/*`
- `feature/*`
- `fix/*`
- `hotfix/*`
- `doc/*`
- `documentation/*`
