# Writing your first cookbook

## Jackchop!

Jackchop will create your cookbook and set it up the Berkshelf way. It won't create a git repo though, so talk to anyone on The Fellowship team to do that for you. All Chef Cookbooks are in the Rally-Cookbooks repo directory.


## Berksfile and metadata.rb


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
