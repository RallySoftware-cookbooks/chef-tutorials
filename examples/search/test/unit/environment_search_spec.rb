require_relative 'spec_helper'

describe 'search::environment_search' do

  before do
    Chef::Recipe.any_instance.stub(:search)
                .with(:node, 'chef_environment:test')
                .and_return([{:name => 'ec2-bar-01', :environment => 'test'}, 
                             {:name => 'ec2-bar-02', :environment => 'test'}, 
                             {:name => 'ec2-bar-03', :environment => 'test'}])
    Chef::Recipe.any_instance.stub(:search)
                .with(:node, 'chef_environment:production')
                .and_return([{:name => 'physical-baz-01', :environment => 'production'}, 
                             {:name => 'physical-foo-01', :environment => 'production'}, 
                             {:name => 'physical-foobar-01', :environment => 'production'}])
  end

  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'search::environment_search' }  
  subject { chef_run }
  it { should create_file_with_content '/root/test_nodes', /ec2-bar-01/ }
  it { should create_file_with_content '/root/test_nodes', /ec2-bar-02/ }
  it { should create_file_with_content '/root/test_nodes', /ec2-bar-03/ }

end
