---
layout:   post
title:    "Cheat sheet git"
date:     2020-09-14 23:00:00 +0200
tags:     
 - linux 
 - git 
 - cheat sheet
 - vcs
---
*My personal cheat sheet for using git via the terminal.*

## Staging, committing, pushing, pulling
```console
$ git add .                     # Stage all changes
$ git add <file>                # Stage the given file
$ git commit -m "<message>"     # Commit staged changes locally with the given message
$ git commit --amend            # Change the commit message of the last commit
$ git push                      # Push commits to the remote server
$ git pull -p                   # Fetch and merge commits from remote branch and remove deleted branches
$ git pull origin <branch>      # Pull in the commits from another branch
$ git merge --abort             # In case a pull gave merge conflicts, rollback everything
$ git fetch                     # Get the new commits, but do not apply them yet
```

## Branching
```console
$ git branch <branch>           # Create a new branch
$ git checkout <branch>         # Switch to the given branch
$ git branch -d <branch>        # Delete branch, but check that it has been merged
$ git branch -D <branch>        # Delete branch whether or not it has been merged
```

## Correcting
```console
$ git reset --soft HEAD~1       # Undo the last commit, but keep the changes staged
$ git reset --hard HEAD~1       # Undo the last commit and remove the changes
$ git checkout c5f567 -- file1/to/restore file2/to/restore # Restore files to the given revision
$ git rebase -i HEAD~3          # Interactively make changes on the last 3 commits
```

## Other
```console
$ git status                                        # Get status info of the repo
$ git log --oneline <file>                          # List the history in oneliners
$ git grep <expression> $(git rev-list --all)       # Search for file content in the entire repo history
$ git rev-list --all | xargs git grep <expression>  # Like above, but for larger repos
$ git log -p HEAD..origin/master                    # Show list of differences after a git fetch
$ git diff HEAD...origin/master                     # Show a single diff after git fetch
```
