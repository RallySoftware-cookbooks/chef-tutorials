# So you want to learn chef?

## Getting started

### Step 1 - Come talk with us!
There are few things you need to do before you can start writing cookbooks for your application. The first and most important step is come talk with the Fellowship team. You should be ready to discuss important details about your application such as - 
  * What language tools do you need? ie. Do you need leiningen? grails? gradle?
  * Are you using a database that will run on the box or on another system that will be provisioned by chef as well?
    * What database will you be using? Mongo? Cassandra?
  * Where are the hosts that are being provisioned? EC2? Boulder? Prod? Test?
  * What are you dependencies? Do you need something installed on the box that may not be there? 
  * How are you going to build your artifacts? Do you need your own CI system?

### Step 1.5 - Watch this video
[The Berkshelf Way](http://youtu.be/hYt0E84kYUI)

### Step 2 - Get Jackchop installed
Jackchop is a tool that the Fellowship has created to assist with cookbook development. To install jackchop run the following command:
* `gem install jackchop --source http://gems.f4tech.com`

### Step 3 - Get knife installed
(Knife is a command-line tool that provides an interface between a local chef-repo and the server.)
A member of the Fellowship team will have to assist you in getting knife setup on your machine.

### Step 4 - Other tools
* You need to have the lastest versions of [virtual box](https://www.virtualbox.org/wiki/Downloads) and [vagrant](http://downloads.vagrantup.com/).

### Step 5 - Now what?
We recommend reading through [your first cookbook](your-first-cookbook.md) first. However, this repo should contain all of the information you need for writing cookbooks and how to get those into "production". If you have any questions feel free to contact the Fellowship team or just stop by.

Also we are willing to pair with any team that is doing chef development work to help get you started with your cookbook!

* [Knife Cheat Sheet](http://docs.opscode.com/_images/qr_knife_web.png)
* [About Knife](http://docs.opscode.com/knife.html)
