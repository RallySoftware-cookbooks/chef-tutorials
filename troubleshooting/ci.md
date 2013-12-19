# CI Troubleshooting

##  Table of Contents

- [Release already tagged](#release-already-tagged)   
- [Push failed after VERSION bump](#push-failed-after-version-bump)   

## Release already tagged

Example failure:

```shell
16:50:01 + bundle exec rake ci
16:50:04 rake aborted!
16:50:04 Tag v1.1.7 has already been created.
16:50:04
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-5293cf4b48db/lib/cookbook/development/rake/release_tasks.rb:48:in
`release_cookbook'
16:50:04
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-5293cf4b48db/lib/cookbook/development/rake/release_tasks.rb:39:in
`block in define'
16:50:04
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bin/ruby_executable_hooks:15:in
`eval'
16:50:04
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bin/ruby_executable_hooks:15:in
`<main>'
16:50:04 Tasks: TOP => ci
16:50:04 (See full trace by running task with --trace)
16:50:04 Build step 'Execute shell' marked build as failure
16:50:04 Finished: FAILURE
```

### What happened? 
- The cookbook-development rake task determined that the version listed
  in the `VERSION` file has already been tagged in git.

### Possible Cause
- The `VERSION` file was not incremented and pushed to git after the
  last CI run or manual release.

### Solution
Example step-by-step:

- Open `VERSION` in your favorite editor.
- Increment the version per [this](http://semver.org/) guide
- `git add VERSION`
- `git commit -am 'Bumped to version x.y.z'`
- `git push`
    
## Push failed after VERSION bump

Example failure:

```shell
11:33:21 Finished in 0.79722 seconds
11:33:21 12 examples, 0 failures
11:33:21 Tagged v1.1.15.
11:33:21 Running berks upload...
11:33:21 Using ad_auth (1.1.15)
11:33:21 Using yum_rally (0.5.4)
11:33:21 Using yum (2.4.0)
11:33:21 Uploading ad_auth (1.1.15) to: 'https://api.opscode.com:443/organizations/rally'
11:33:24 Uploading yum_rally (0.5.4) to: 'https://api.opscode.com:443/organizations/rally'
11:33:24 Uploading yum (2.4.0) to: 'https://api.opscode.com:443/organizations/rally'
11:33:25 Version bumped to 1.1.16
11:33:25 Committing /home/chefbuild/workspace/ad_auth/VERSION...
11:33:25 [master d8b314b] Version bump to 1.1.16
11:33:25  1 files changed, 1 insertions(+), 1 deletions(-)
11:33:25 Pushing git changes...
11:33:26 rake aborted!
11:33:26 Couldn't git push. `git push origin --tags : 2>&1' failed with the following output:
11:33:26 
11:33:26 To git@github.com:RallySoftware-cookbooks/ad_auth.git
11:33:26  * [new tag]         jenkins-ad_auth-74 -> jenkins-ad_auth-74
11:33:26  * [new tag]         v1.1.15 -> v1.1.15
11:33:26  ! [rejected]        master -> master (non-fast-forward)
11:33:26 error: failed to push some refs to 'git@github.com:RallySoftware-cookbooks/ad_auth.git'
11:33:26 To prevent you from losing history, non-fast-forward updates were rejected
11:33:26 Merge the remote changes before pushing again.  See the 'Note about
11:33:26 fast-forwards' section of 'git push --help' for details.
11:33:26 
11:33:26 
11:33:26 This could be a result of unmerged commits on master. Refer to https://github.com/RallySoftware-cookbooks/chef-tutorials/blob/master/troubleshooting/ci.md to resolve this issue.
11:33:26 
11:33:26 /home/chefbuild/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-a5e473cbdda5/lib/cookbook/development/rake/release_tasks.rb:91:in `perform_git_push'
11:33:26 /home/chefbuild/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-a5e473cbdda5/lib/cookbook/development/rake/release_tasks.rb:84:in `git_push'
11:33:26 /home/chefbuild/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-a5e473cbdda5/lib/cookbook/development/rake/release_tasks.rb:65:in `release_cookbook'
11:33:26 /home/chefbuild/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-a5e473cbdda5/lib/cookbook/development/rake/release_tasks.rb:41:in `block in define'
11:33:26 /home/chefbuild/.rvm/gems/ruby-1.9.3-p448/bin/ruby_executable_hooks:15:in `eval'
11:33:26 /home/chefbuild/.rvm/gems/ruby-1.9.3-p448/bin/ruby_executable_hooks:15:in `<main>'
11:33:26 Tasks: TOP => ci
11:33:26 (See full trace by running task with --trace)
11:33:26 Build step 'Execute shell' marked build as failure
11:33:26 Finished: FAILURE
```

### What happened?
- Tests passed
- Previous version was tagged in git
- Previous version was uploaded to hosted chef
- Version was successfully bumped and committed locally
- Push of committed bumped `VERSION` file failed

### Possible Cause
This is caused by commits showing up on master after a CI run has kicked
off. 

### Solution
Example step-by-step:

- Open `VERSION` in your favorite editor.
- Increment the version per [this](http://semver.org/) guide
- `git add VERSION`
- `git commit -am 'Bumped to version x.y.z'`
- `git push`

