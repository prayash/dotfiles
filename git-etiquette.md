# Git Etiquette

- Always `git add . --patch` to make sure that files which do not relate to a specific commit are not being added. This helps prevent print statements and other junk from being committed.

- Use `git commit --amend` to rewrite the history of your last commit. This is useful for changing the last commit and it does not an extra commit to the history. `git add <file>` as always and then use `git commit --amend` to fix the last commit. Then you must force push to your own branch using `git push -f <remote> <branch-name>`.

## Merging a feature branch
- Make feature branch under initial. Commit changes to that branch.
- Once ready, make a PR. Implement feedback from reviewers.
- When ready to merge into master:
  - Checkout master branch, pull so master is fully up to date to the remote.
  - Checkout feature branch again.
  - `git rebase master`, Git will automagically try to resolve all merge conflicts. If it can't, it will pause the rebase and ask you to resolve them.
    - `git rebase --continue` - after fixing conflicts, add files to stage then run this to proceed with the rebase
    - `git rebase --skip` - sometimes if you've already resolved conflicts in a file, git will still halt the rebase and you may need to skip here or there
    - `git rebase --abort` - cancels the rebase (if something goes wrong or you aren't sure whether you successfully resolved conflicts you can start over)
  - Verify that everything is still functional before force pushing.
  - `git push -f <remote> <branch-name>`
  - `git checkout master`
  - `git merge <branch-name>`

## Replaying Commits from another remote (ie: Bitbucket)
- git checkout develop
- git pull --rebase origin develop
- git pull --rebase bitbucket develop
- git push bitbucket develop
- git push origin develop
- git checkout <branch>
- git rebase develop

## Neat features
- Use `git bisect` to find a culprit commit which introduced a bug at some point in time.
- Use `git ls-files | grep ".js\$"` to list all js files tracked by Git.