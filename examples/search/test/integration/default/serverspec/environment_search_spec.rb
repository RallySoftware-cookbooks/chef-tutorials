require_relative 'spec_helper'

describe 'search::environment_search' do

  describe file('/root/test_nodes') do
    its(:content) { should match 'Name        - ec2-bar-01' }
    its(:content) { should match 'Name        - ec2-bar-02' }
    its(:content) { should match 'Name        - ec2-bar-03' }
    its(:content) { should match 'Name        - ec2-foo-01' }
    its(:content) { should match 'Name        - ec2-foo-02' }
    its(:content) { should match 'Name        - ec2-foo-03' }
  end

  describe file('/root/prod_nodes') do
    its(:content) { should match 'Name        - physical-baz-01' }
    its(:content) { should match 'Name        - physical-foo-01' }
    its(:content) { should match 'Name        - physical-foo-02' }
    its(:content) { should match 'Name        - physical-foobar-01' }
  end

end