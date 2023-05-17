# SECTION 1: GIT

## 1. if you using git stash, where will it save data? What is diff b/w index and staging area?

* Git stash is used to save the changes of the working copy, we can work on some other parts and we can re-apply once we are done.
* Git stash will store the data to the local of your git repo. it will not transfered to the server when you push.
* These command can help us in workflow of the stash.
```
git stash
git stash pop
git stash apply
```
## 2. when would individuals use git rebase, git fast-forward, or a git fetch then push?

The individuals would use different GIT commands depending on their specific requirements or needs.
* Git rebase - we can use when we want to integrate the changes from one branch to another branch while maintaining a linear commit history.
* Git fast-forward - we can use this command when the branch we want to merge has no new commits of its own and only includes commits already present in the target branch(main branch)
* Git fetch - we can use this, if we are downloading content from a remote repo, git fetch will download the remote repo but it will update your local repo working state, leaving your current work intact.
* git push - it will download the remote content for the active local branch and immeditaely execute (have the latest commits).

## 3. How to revert already pushed changes?

We can revert the already pushed changes in Git by using the ```git revert``` command.
* To identify the commit id or hash which we want to revert by using ```git log``` or ```git history```
* Then this command will revert back to the particular commit.
```
git revert <Commit-id or hash>
```
* The other option is to come back to particular state and remove everything beyond this commit. (hard will reset working tree and index)
```
git reset --hard <commit-id or hash>
```

## 4. What is the difference between cherry picking commits vs trying a hard reset. What is the final outcome of the head reference?

* Cherry Picking  - we can use this, when we particularly want to pick the particular or specific commits froom one branch and apply them to another branch. The head reference remains unchanged. It still points to the latest commts on the branch you are currently on.
* Hard reset - We can use this, when we want to moves the branch pointer to particular or specific commit discarding any commits after that point. The head reference is update to point to that commit. simply, it changes the state of branch and the head reference also.

## 5. Explain the difference between git remote and git clone?

### Git remote 
* It is used to manage connections to remote repos 
* It deals with managing the remote repos links and names.
* It is used after cloning to set up connections of remote repos
### Git clone 
* It is used to create a local copy of a remote repos.
* It deals with the creating local copy of entire remote repo history and code.
* It is the initial step to create local repo.

# SECTION 2 - TERRAFORM





