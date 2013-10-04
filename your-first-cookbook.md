# Writing your first cookbook

## Jackchop!
Alright you want to create your first cookbook. You followed all of the instructions [here](README.md) and have all the necessary tools at your disposal. It's a good idea to have a central place to keep all of your cookbooks, the Fellowship follows the convention of placing them in `~/projects/cookbooks` so we highly recommend you do the same.

Once you are in that directory run the following command -

```bash
jackchop cookbook create <name of your cookbook>
```

This should create a new directory in `cookbooks` named whatever you passed in to jackchop. `CD` into that directory and let's take a look at what was created.

You should see the following directories -
* `attributes` - This is where you still store the default attributes for your cookbook
* `recipes` - Recipes are the "logic" of your cookbook
* `tests` - Should be pretty obvious what goes in this directory =)

The following files are also created - 
* `.kitchen.yml` - Used to configure the test-kitchen framework
* `Berksfile` - This is the file used by Berkshelf to determine dependencies of your cookbook during development/testing.
* `chefignore` - This file tells the chef server what files to ignore during uploads and syntax checking.
* `metadata.rb` - Used to describe the cookbook

Next, issue the following commands and make sure everything passes -

```bash
bundle install
```

```bash
rake test
```

Jackchop will also init a git repo for you when you create a cookbook. However, it does not create a github repo! Currently, all cookbooks are under the RallySoftware-cookbooks orginization which means the repo will need to be created by a member of the Fellowship team. This functionality may eventually be extended to Jarvis, but for now we will need to help you.

Your cookbook is now the baddest in all of Revere!

## Berksfile and metadata.rb
Before we talk about writing your first recipe I want to describe the purpose of the Berksfile and the metadata.rb file. 
### Berksfile
The Berksfile is used by [Berkshelf](http://berkshelf.com/) to help manage the dependencies of your cookbook during development and test. It will allow you to specify a cookbook depenency as a git repo, a path on your local machine, or as version (using the bundler syntax). 

```ruby
chef_api :config
site :opscode

metadata

cookbook 'memcached', '~> 0.1.0'
cookbook 'foo', path: '/Users/localadmin/projects/cookbooks/foo'
cookbook 'mysql', github: 'opscode-cookbooks/mysql'
cookbook 'mysql', git: 'git://github.com/opscode-cookbooks/mysql.git'
cookbook 'mysql', git: 'https://github.com/opscode-cookbooks/mysql.git', branch: 'foodcritic'
cookbook 'mysql', git: 'https://github.com/opscode-cookbooks/mysql.git', ref: 'eef7e65806e7ff3bdbe148e27c447ef4a8bc3881'
```

The first line (`chef_api :config`) in this mock `Berksfile` says to use the Berkshelf config (located at `~/.berkshelf/config.json`) to learn how to communicate with your Chef Server. In this particular case, it will end up using your knife config to reach out and fetch the cookbooks. 

Next, `site :opscode` says to use the community site to fufil any cookbooks that could not be found on your Chef Server and locatins are not specified for the cookbook itself.

Finally, we see `metadata` which tells Berkshelf to use the `metadata.rb` file to locate additional dependencies that are not specified in the `Berksfile`.

### Metadata.rb
The `metadata.rb` file is what is used by Chef to resolve dependencies when the `chef-client` is executing on a node. This means that you MUST specify your dependent cookbooks in this file for them to be included when the node is converged. 



## Writing recipes

Writing recipes is easy. The most important thing to figure out first is the order in which you want components and resources created. Once you figure that out, then first start in the Default recipe. go to [resources](docs.opscode.com/chef/resources.html)

Start by creating a User. [resource - user](docs.opscode.com/chef/resources.html#user)

```
user 'my_machine_user'
```

## Setting and using attributes

## Using Node attributes

## Using other cookbooks The Fellowship team wrote.




## Writing tests


### Unit tests


### Integration tests


### Manual testing with Vagrant


## Writing a kick ass README!

All cookbooks must have a README, it is required!

## Publishing your cookbook to the chef server
