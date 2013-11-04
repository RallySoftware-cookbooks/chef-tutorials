## Description
Describe what this cookbook does. Include information about when to use certain recipes if more than 1 exists.

## Requirements
### Platform
List the supported platforms from the metadata.rb file -
* Centos 6.4
* Ubuntu 12.4

### Dependencies
There are two use cases for documenting your dependencies -

1) You have a dependent cookbook that needs to install something before your cookbook can converge - Java. This means you do an include_recipe and set the necessary attributes for the installation to complete correctly. Instead of documenting the attributes in your Readme.md file just document the cookbook and the recipe you are including with link to the github page where it can be found.

2) You rely on a piece of software to be installed before your cookbook can be used yet you do not install that software yourself. Instead, it must be included in the runlist of the node (either through a role or some other means). Please document this here and include a link to the github page of the cookbook.

## Attributes
### default
See `attributes/default.rb` for default values

List all of your attributes in your default.rb file here. Use the following notation -
* `node[:foo][:bar]` = Describe what the attribute is used for.

(Please document all of your attribute files, not just the default.rb)

## Recipes
###default
Describe your default recipe here. Include information such as the included recipes, users and directories created, and any logic used during convergence. (If more than 1 recipe exists please document them as well)

## Resources and Providers
### My-Foo-Provider
If your cookbook contains an LWRP please document how to use it with examples in this section. List any attributes that can be set for it to be used.

```ruby
my_foo_provider "foo" do
  bar "/foo/bar"
  baz 22
end
```

### LWRP attributes:
* `attribute-1` - My foo attribute
* `attribute-2` - My foo attribute
* `attribute-3` - My foo attribute

See `https://github.com/RallySoftware-cookbooks/monit/blob/master/README.md#resources-and-providers` for an example on how to document your LWRP.

## License
Copyright (C) 2013 Rally Software Development Corp

Distributed under the MIT License.
