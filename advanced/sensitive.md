# Storing Sensitive Data in Chef

We currently use [chef-vault](https://github.com/Nordstrom/chef-vault)
to encrypt sensitive data used in cookbooks. Any sensitive credentials
should be stored in encrypted data bags using chef-vault.

## Table of Contents

- [Data Bag Structure](#data-bag-structure)
- [Managing Encrypted Data Bags](#managing-chef-vault-encrypted-data-bags)
  - [Installing chef-vault](#installing-chef-vault)
  - [Creating a new data bag](#creating-a-new-data-bag)
  - [Creating with a JSON file](#creating-with-a-json-file)
  - [Creating with CLI arguments](#creating-with-cli-arguments)
  - [Displaying data in an encrypted data bag](#displaying-data-in-an-encrypted-data-bag)
  - [Updating a data bag](#updating-a-data-bag)
    - [Adding or replacing a VALUE in an existing data bag](#adding-or-replacing-a-value-in-an-existing-data-bag)
    - [Adding and Removing clients](#adding-and-removing-clients)
    - [Adding and Removing admins](#adding-and-removing-admins)
- [Recipe Examples](#recipe-example)

## Data Bag Structure

  Because data bags are global we have a standard structure for
sensitive information which conforms to our use of environments. Data
bags are structured in JSON and need to include the environment name as
the top level VALUE for any other attributes used. Below is an example of
a data bag supporting the 'alpha' and 'beta' environments.

```json
{
  "id": "testdata",
  "alpha": {
    "sql_user": "user"
  },
  "beta": {
    "sql_user": "user"
  }
}
```

This data bag contains a few components:

- `"id": "testdata"` - This is the data bag ITEM identifier, in this
  case "testdata".
- `"alpha":` - This is the top level VALUE for the "alpha" environment.
  There needs to be a matching VALUE like this for any environment where
the information in this data bag will be used.
- `"sql_user"` - This is the key/value pair inside the data bag.

Note that the data bag must be valid [JSON](http://www.json.org/), be
familiar with proper JSON syntax.

## Managing chef-vault Encrypted Data Bags

Data bags are created using knife with the chef-vault gem installed.
This provides a set of 'encrypt' and 'decrypt' commands.

### Installing chef-vault
You should follow the install instructions on
the [chef-vault](https://github.com/Nordstrom/chef-vault) page, the
tl;dr is `gem install chef-vault`.

### Creating a new data bag
New data bags are created with the `knife
encrypt create` command. They can be created either using a JSON file as
the source or directly on the command line.

#### Creating with a JSON File
Using the json stanza above, you could save it in a file called
`testdata.json`.  The create command-line using the json file would look
like this:

```shell
$ knife encrypt create testdatabag testdata -S "name:hosta* OR name:hostb*" \
--json testdata.json --mode client --admins admin1,admin2
```

This command-line contains several components:

- `testdatabag` - This is the data bag name.
- `testdata` - This is the data bag ITEM and should match the `id` in
  the json file.
- `-S "name:hosta* OR name:hostb*"` - This is a SOLR search string that
  matches clients that should have access to decrypt the data bag.
- `--mode client` - This is necessary to use chef-vault with hosted chef
  or standalone chef server.
- `--admins admin1,admin2` - This is a comma-separated list of admin
  usernames or client names that should have access to decrypt the data
bag.  You __MUST__ include yourself in this list if you want to be able to
perform further modifications to this data bag.

#### Creating with cli arguments
You can also pass the same JSON data to the command using the command
line like this:
```shell
$ knife encrypt create testdatabag testdata -S "name:hosta* OR name:hostb*" \
'{"id":"testdata","alpha":{"sql_user":"user"},"beta":{"sql_user":"user"}}' \
--mode client --admins admin1,admin2
```
You could confirm that this data bag has been created using the `knife
data bag` command

`$ knife data bag show testdatabag testdata -Fj`

This should produce:
```json
{
  "id": "testdata",
  "alpha": {
    "encrypted_data":
"islhGfkW4jDt3Ve9S8lx7/76Mpfo+FonAO/ov5B2VWXZadoz7JA8fSUAfyup\ng5sqZFPQ6G9BO8wzDfX68Lk1pw==\n",
    "iv": "Olb5AYnBMjZvDsXJ373bbQ==\n",
    "version": 1,
    "cipher": "aes-256-cbc"
  },
  "beta": {
    "encrypted_data":
"1LLxlbkqM9j6DwiwbEhtwti+IpjScrRvOy4qGHMbi+QLyG9e9EYRfPgBHTY1\n1wGCNTPTFNuqPQWBm+6tC4rxzw==\n",
    "iv": "ieRNzxLWre8nOs5qJRHyaw==\n",
    "version": 1,
    "cipher": "aes-256-cbc"
  }
}
```

The contents are encrypted because you are not using the decrypt
commands to view the data. The above example is how the data will appear
to anyone who does not have rights to decrypt the contents of the data
bag.

### Displaying data in an encrypted data bag
Once you have created an encrypted data bag using chef-vault you can
view the decrypted contents of the data bag (*assuming you have included
yourself as an admin!*)

Note that you must specify both the data bag _ITEM_ in addition to the
_VALUE_ you would like to retrieve from the data bag, in this example
the VALUE is `alpha`.

`$ knife decrypt testdatabag testdata alpha`

Should produce:
```
testdatabag/testdata
        alpha: {"sql_user"=>"user", "sql_password"=>"password"}
```

### Updating a data bag
Updating a data bag allows you to modify all attributes of the encrypted
data in a data bag:

- Add new VALUE to an existing data bag (add)
- Update VALUE in an existing data bag (replace)
- Update which nodes a data bag is encrypted for (add/remove)
- Update which admins have access to a data bag (add/remove)

Note that operations above listed as "add" are additive. For example, if you
update a data bag with `--admins admin3` which already permits admin1 &
admin2, it will now permit admin1, admin2, and admin3. Similarly, adding
a new VALUE will not remove existing VALUE entries. However, updating an
existing VALUE will replace all of the data in that VALUE.

#### Adding or replacing a VALUE in an existing data bag
If you have an existing data bag you can add a new VALUE using the
update command:
```shell
$ knife encrypt update testdatabag testdata '{"gamma":{"sql_user":"user"}}' \
--mode client
```

If `"gamma"` already exists, its data will be replaced.

If you would like to use a JSON file as the source of data, you can use
the `--json` argument instead of passing in a JSON string:

Contents of data.json would be:

```json
{
  "gamma": {
    "sql_user": "user"
  }
}
```

```shell
$ knife encrypt update testdatabag testdata --json data.json --mode client
```

#### Adding and Removing clients

Add:

`$ knife encrypt update testdatabag testdata -S 'name:newhosts*'`

Remove:

`$ knife encrypt remove testdatabag testdata -S 'name:newhosts*'`

#### Adding and Removing admins

Add:

`$ knife encrypt update testdatabag testdata --admins admin4`

Remove:

`$ knife encrypt remove testdatabag testdata --admins admin4`

## Recipe Example
To use chef-vault within a recipe you must install the gem and require
it:

```ruby
chef_gem 'chef-vault'

require 'chef-vault'

item = ChefVault::Item.load('testdatabag', 'testdata')

credentials = item[node.chef_environment]

node.default[:cookbook][:sql_user] = credentials['sql_user']
node.default[:cookbook][:sql_password] = credentials['sql_password']
node.default[:cookbook][:sql_url] = credentials['sql_url']
```

## Recipe Testing Example

### Unit testing (with chefspec)

You'll need to add `gem chef-vault` to your `Gemfile`.

You need to mock out the call to ChefVault in order to
test:

```ruby
require_relative 'spec_helper'

require 'chef-vault'

describe 'cookbook::default' do
  let(:node) { chef_run.node }
  let(:databag_hash) do
    { '_default' => {
        'sql_user' => 'herp',
        'sql_password' => 'derp',
        'sql_url' => 'jdbc:oracle:thin:@//somedbhost:1521/derpadb'
      }
    }
  end

  subject(:chef_run) do
    ChefVault::Item.stub(:load).and_return(databag_hash)
    ChefSpec::Runner.new.converge described_recipe
  end

  it { should install_chef_gem('chef-vault') }

  it { node[:cookbook][:sql_user].should == 'herp' }
  it { node[:cookbook][:sql_password].should == 'derp' }
  it { node[:cookbook][:sql_url].should == 'jdbc:oracle:thin:@//somedbhost:1521/derpadb' }
end
```

### Integration testing

For integration testing using test-kitchen and serverspec, we've created
a test cookbook which does NOT use chef-vault.  This validates that
things end up on disk where we expect them, allowing us to stub out the
calls to chef-vault.

