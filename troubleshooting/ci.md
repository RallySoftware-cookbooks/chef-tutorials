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
10:29:36 Finished in 0.79761 seconds
10:29:36 12 examples, 0 failures
10:29:36 Tagged v1.1.14.
10:29:36 Running berks upload...
10:29:36 Using cookbook (1.1.14)
10:29:36 Using yum_herpaderp (0.5.4)
10:29:36 Using yum (2.4.0)
10:29:36 Uploading cookbook (1.1.14) to:
'https://api.opscode.com:443/organizations/herpaderp'
10:29:45 Uploading yum_herpaderp (0.5.4) to:
'https://api.opscode.com:443/organizations/herpaderp'
10:29:46 Uploading yum (2.4.0) to:
'https://api.opscode.com:443/organizations/herpaderp'
10:29:46 Version bumped to 1.1.15
10:29:46 Committing /home/builduser/workspace/cookbook/VERSION...
10:29:46 [master d2bcd3e] Version bump to 1.1.15
10:29:46  1 files changed, 1 insertions(+), 1 deletions(-)
10:29:46 Pushing git changes...
10:29:48 Untagging v1.1.14 due to error.
10:29:48 rake aborted!
10:29:48 Couldn't git push. `git push origin --tags : 2>&1' failed with
the following output:
10:29:48 
10:29:48 To git@github.com:herpaderp-cookbooks/cookbook.git
10:29:48  * [new tag]         jenkins-cookbook-67 -> jenkins-cookbook-67
10:29:48  * [new tag]         v1.1.14 -> v1.1.14
10:29:48  ! [rejected]        master -> master (non-fast-forward)
10:29:48 error: failed to push some refs to
'git@github.com:herpaderp-cookbooks/cookbook.git'
10:29:48 To prevent you from losing history, non-fast-forward updates
were rejected
10:29:48 Merge the remote changes before pushing again.  See the 'Note
about
10:29:48 fast-forwards' section of 'git push --help' for details.
10:29:48 
10:29:48
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-997a9e5a1e5a/lib/cookbook/development/rake/release_tasks.rb:88:in
`perform_git_push'
10:29:48
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-997a9e5a1e5a/lib/cookbook/development/rake/release_tasks.rb:81:in
`git_push'
10:29:48
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-997a9e5a1e5a/lib/cookbook/development/rake/release_tasks.rb:61:in
`block in release_cookbook'
10:29:48
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-997a9e5a1e5a/lib/cookbook/development/rake/release_tasks.rb:139:in
`tag_version'
10:29:48
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-997a9e5a1e5a/lib/cookbook/development/rake/release_tasks.rb:57:in
`release_cookbook'
10:29:48
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bundler/gems/cookbook-development-997a9e5a1e5a/lib/cookbook/development/rake/release_tasks.rb:39:in
`block in define'
10:29:48
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bin/ruby_executable_hooks:15:in
`eval'
10:29:48
/home/builduser/.rvm/gems/ruby-1.9.3-p448/bin/ruby_executable_hooks:15:in
`<main>'
10:29:48 Tasks: TOP => ci
10:29:48 (See full trace by running task with --trace)
10:29:48 Build step 'Execute shell' marked build as failure
10:29:48 Finished: FAILURE
```

### What happened?
- Tests passed
- Previous version was tagged in git
- Previous version was uploaded to hosted chef
- Version was successfully bumped and committed locally
- Push of committed bumped `VERSION` file failed

NOTE: The error message `Untagging v1.1.14 due to error.` is inaccurate
and no tag is being removed at this point in the job.


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

