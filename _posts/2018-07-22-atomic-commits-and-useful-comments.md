---
layout:   post
title:    "Atomic commits and useful comments"
date:     2018-07-22 12:00:00 +0200
tags:     
  - quality
  - "version control"
  - git
featured_article: true
---
Every serious development project needs some sort of version control. Popular options today include `git`, `mercurial`, `bazar` and `svn`. Each of these systems works a bit differently, but all of them have the concept of a 'commit' in common.

## What is a commit?
Committing something to version control means that you have made some changes to your code and want to save these changes as a new version. Also, you want to be able to go back at anytime to the version of your code as it was before your commit. And likewise you want to be able to reproduce the current version of your code in the future, when possibly many other version have succeeded it. All this you achieve by committing code to your version control system.

In principle, version control systems to not limit you in how you commit your code. You could go on and make a lot of changes to your code, and commit when it's time to go to bed, for example. Likewise, you are free to commit code that makes the compilation of the code fail, no matter how annoying this is to yourself and other developers.

## What is an atomic commit?
An atomic commit constrains a commit in two ways:
1. You commit small changes, typically as small as possible to implement a feature. If the feature requires many changes to the code in different places, break it up into several commits.
2. The commit may not break the build. It should also no violate any test cases, unless you use TDD or BDD, in which case adding failing tests is part of the process.

## How to make an atomic commit
The description I have given above is not exact science. Every code base under version control is different and it would be impossible to define a single procedure that applies to all situations. It boils down to guiding principles and common sense.

So start thinking about the impact on your code base as soon as you define a requirement. If it needs a lot of changes in different places, maybe you can break it up into several requirement. Likewise, when developing, think about what changes are most likely to come in the future and try to set up your code so that such a change is easily performed with the fewest impact on your code.

You will find that the guidelines given here combine very well with other development best practices, like agile-style requirements and loose coupling of code. This way, one practice reinforces the others.
