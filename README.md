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

## 1. what is the difference between terraform count and for_each meta data function? and give a scenario-based example to use them.

Both the argument is used to manage the multiple resource instances.

**Terraform Count**
* This argument is used with in a resource block to specify the number of resource instance that can be created. the count value must be a static number or expression.
**Scenario**
If suppose you want to create a number of instances with predefined or fixed configurations. we can use the ```terraform count``` and specify the count which the number of instances to be created.

**Terraform for_each**
* This argument is also used within resource block to dynamically create the multiple instances with different configurations. The ```for_each``` should be a map or key-value pairs.
**Scenario**
If suppose you wan to create a multiple instances with different configuration the ```for_each``` will be idle.

## 2. What is Terraform taint ? When to use it? When would you use terraform state rm vs terraform taint?

**Terraform Taint** 
* It is used to mark a specific resources instance as tainted. It means telling terraform that the resource become degraded or damaged and required recreation.
* We can use when you want to force the re-creation of a specific resource due to issue or to trigger the replacement even if the resource config was not damaged.

**Terraform state rm**
* It is used to remove the resources from the terraform state altogether.
* 
```
terraform state rm [options] ADDRESS...
```

**Difference** - In state rm, the resource will not be recreated to the nexr ```terraform apply```. Because it is no longer present in the state. But in taint it will be recreated on the next ```terrraform apply```.

## 3. How would you show a diagram of all terraform resources in the state file? When is this useful?

* To generate a diagram of all terraform resources in the statefile, we can use various open source tools and libraries available in terraform ecosystem.
* The command line tool the **Terraform Graph** is for generating the terraform resource diagrams.
* 
```
terrafrom graph > graph.dot
```

* This command generates a DOT file contating the resource graph based on the defined terraform configs and state.
*  We can install graphviz which converts the DOt file into the image file.
*  
```
dot -Tpng -o graph.png graph.dot
```

**When to use** - we can able to understand the infrastructure better and helps for enhancement, analysis, troubleshootin etc.,

## 4. Solve this expression:

count = var.run_remote_environment ? var.TFC_RUN_ID !=["Yes"]) : null


* The correct syntax will be 

```
count = var.run_remote_environment ? (var.TFC_RUN_ID != "Yes" ? 1: 0) : 0
```
* var.run_remote_environment - is a boolean variable indicates the remote environment is bein run.
* var.TFC_RUN_ID - it is variable that has the value of the TFC (Terraform cloud run id)
* It checks the remote env is true and if yes it checks the run id not equal to YES.
* If both the condition is passed, the it will set count as 1, indicating the resource should be creeated. any fail check will not create the resource

## 5. How would you apply terraform to multiple accounts simultaneously? We want to ensure this follows secuirty best practices.

* We can apply terraform to multiple accounts simultaneously by adhering the security best practises, we can use seperate terraform workspace for each account and seperate state files and IAM roles.
* We can use **terraform modules** also to encapsulate and resue the common infrastructure component. it can be version controlled as well.








