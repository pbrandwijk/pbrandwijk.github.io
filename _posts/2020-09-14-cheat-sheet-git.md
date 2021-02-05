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
$ git pull -p                   # Fetch and merge commits from the remote branch and remove deleted branches
$ git pull origin <branch>      # Pull in the commits from a remote branch
$ git merge <branch>            # Merge the commits from a local branch into the current branch
$ git merge --abort             # In case a pull gave merge conflicts, rollback everything
$ git fetch                     # Get the new commits, but do not apply them yet
$ git reset --hard HEAD         # Go back to the HEAD revision (undo all changes to versioned files)
$ git checkout --track origin/<branch> # Fetch, track and checkout a branch from origin
```

## Branching
```console
$ git branch <branch>           # Create a new branch
$ git checkout <branch>         # Switch to the given branch
$ git checkout -b <branch>      # Switch to given branch and create it if it didn't exist
$ git branch -d <branch>        # Delete branch, but check that it has been merged
$ git branch -D <branch>        # Delete branch whether or not it has been merged
$ git push origin --delete <branch> # Delete a remote branch
```

## Stashing
```console
$ git stash                     # Stash all changes to versioned files
$ git stash apply               # Apply the last added stash to the current branch
$ git stash drop                # Drop (delete) the last added stash
```

## Correcting
```console
$ git reset --soft HEAD~1       # Undo the last commit, but keep the changes staged
$ git reset --hard HEAD~1       # Undo the last commit and remove the changes
$ git checkout <commit> -- file1/to/restore file2/to/restore # Restore files to the given revision
$ git checkout <commit> .       # Open a previous commit (don't forget the .)
$ git rebase -i HEAD~n          # Interactively make changes on the last n commits
```

## Config
Global configurations are written into `~/.gitconfig.
```console
$ git config --global user.name "<name>"
$ git config --global user.email "<email>"
$ git config --global remote.origin.prune true   # Prune branches by default with push or pull
$ git config --global pull.rebase false  # Set default merge strategy
```

## Metrics
```console
$ git diff --stat HEAD~1 HEAD                       # Show files changed, insertions and deletions between commits
$ git diff --numstat HEAD~1 HEAD                    # Show only the numbers of the stats
$ git diff --unified=0 HEAD~1 HEAD                  # Show diff without any context lines
$ git --no-pager diff                               # Do not use a pager (less)
$ git log --author="<name>" --oneline --shortstat --before="2021-02-06" --after="2021-01-01" # Show stats on selected commits
$ git diff --shortstat $(git merge-base HEAD master) HEAD # Compare the current branch with the state of the master branch at the moment it was branched
$ git --no-pager log --diff-filter=A -- **/<file>   # Find commit in which file was added
$ git --no-pager log --diff-filter=M -- **/<file>   # Find commit in which file was modified
$ git --no-pager log --diff-filter=D -- **/<file>   # Find commit in which file was deleted
```

## Other
```console
$ git status                                        # Get status info of the repo
$ git log --oneline <file>                          # List the history in oneliners
$ git grep <expression> $(git rev-list --all)       # Search for file content in the entire repo history
$ git rev-list --all | xargs git grep <expression>  # Like above, but for larger repos
$ git rev-list --all | xargs -I '{}' git ls-tree --full-tree -r '{}' | grep '.*<file name>*' # Check if the given file name ever existed in the repository
$ git log -p HEAD..origin/master                    # Show list of differences after a git fetch
$ git diff HEAD...origin/master                     # Show a single diff after git fetch
$ git remote -v                                     # Show the protocol and location of the remote repositories
$ git remote set-url origin ssh://git@github.com/<user>/<repo> # Change the protocol to ssh
$ ssh-keygen -t ed25519 -C "<email>" -f ~/.ssh/git_id_ed25519 # Generate an ssh keypair for usage with git via ssh
```
