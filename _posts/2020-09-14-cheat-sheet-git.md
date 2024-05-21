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
$ git push origin +HEAD         # Push the new HEAD to the remote branch (after resetting)
$ git remote prune origin       # Delete all local branches that are not on origin
$ git log origin/master..HEAD   # See commits on local branch that have not yet been pushed to remote branch
```

## Check merge
```console
$ git merge --no-commit --no-ff <branch>  # Check if merging a branch will give merge conflicts without actually performing the merge
$ echo $?                       # Check the error output from the last command
$ git merge --abort             # Undo all changes after a merge conflict
```

## Branching
```console
$ git branch <branch>           # Create a new branch
$ git checkout <branch>         # Switch to the given branch
$ git checkout -b <branch>      # Switch to given branch and create it if it didn't exist
$ git checkout -b <branch> <commit-hash> # Create new branch from a previous commit
$ git checkout --track origin/<branch> # Fetch, track and checkout a branch from origin
$ git branch -d <branch>        # Delete branch, but check that it has been merged
$ git branch -D <branch>        # Delete branch whether or not it has been merged
$ git checkout --orphan <branch> # Create orphan (empty) branch
$ git push origin --delete <branch> # Delete a remote branch
$ git branch -m <new name>      # Rename current branch
$ git push origin -u <new name> # Reset upstream branch
$ git switch <branch>           # Checkout branch, fetch from remote if needed
$ git switch -c <branch>        # Create a new branch and check it out
```

## Tagging
```console
$ git tag                       # Show current tags
$ git tag <tagname>             # Create a new tag
$ git tag <tagname> -a          # Create a new tag with description
$ git push origin <tag>         # Push individual tag to remote
$ git push origin --tags        # Push all tags to remote
```

## Stashing
```console
$ git stash list                # List all available stashes
$ git stash                     # Stash all changes to versioned files
$ git stash push -m "<name>"    # Store a named stash
$ git stash apply               # Apply the last added stash to the current branch (keeps the stash)
$ git stash apply --index       # Same as above, but also differentiate between staged and unstaged 
$ git stash pop                 # Same as apply, but removes the stash from the stack
$ git stash drop                # Drop (delete) the last added stash without applying
$ git stash apply <name>        # Apply a named stash
$ git stash apply stash@{n}     # Apply stash number n (latest is 0)
```

## Correcting
```console
$ git reset --soft HEAD~1       # Undo the last commit, but keep the changes staged
$ git reset --hard HEAD~1       # Undo the last commit and remove the changes
$ git push -f origin <branch>   # After local reset, also delete the commits (s) from remote
$ git checkout <commit> -- file1/to/restore file2/to/restore # Restore files to the given revision
$ git checkout <commit> .       # Open a previous commit (don't forget the .)
$ git rebase -i HEAD~n          # Interactively make changes on the last n commits
$ git restore --staged <file>   # Undo staging
$ git clean -n                  # Check which untracked files would be removed
$ git clean -f                  # Remove untracked files
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
$ git status -uall                                  # Get repo info, files in new dirs are mentioned explicitly
$ git log --oneline <file>                          # List the history in oneliners
$ git grep <expression> $(git rev-list --all)       # Search for file content in the entire repo history
$ git rev-list --all | xargs git grep <expression>  # Like above, but for larger repos
$ git rev-list --all | xargs -I '{}' git ls-tree --full-tree -r '{}' | grep '.*<file name>*' # Check if the given file name ever existed in the repository
$ git log -p HEAD..origin/master                    # Show list of differences after a git fetch
$ git diff HEAD...origin/master                     # Show a single diff after git fetch
$ git remote -v                                     # Show the protocol and location of the remote repositories
$ git remote show origin                            # Show info about remote repository
$ git remote set-url origin ssh://git@github.com/<user>/<repo> # Change the protocol to ssh
$ git log --pretty=format: --name-only --diff-filter=A | sort -u # Show all files that ever existed in the current branch
$ git log --all --pretty=format: --name-only --diff-filter=A | sort - # Same as above, but in the entire repo
$ ssh-keygen -t ed25519 -C "<email>" -f ~/.ssh/git_id_ed25519 # Generate an ssh keypair for usage with git via ssh
$ git clean -fdx                                    # Remove all untracked files
$ git grep "<string or regexp>" $(git rev-list --all) # Text search through all local branches of the repository
```
