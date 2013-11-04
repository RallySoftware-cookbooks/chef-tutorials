require_relative 'spec_helper'

describe 'search::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'search::default' }
  it 'should do something'
end
