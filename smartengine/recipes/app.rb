remote_file '/etc/apt/sources.list.d/couchbase.list' do
  source 'http://packages.couchbase.com/ubuntu/couchbase-ubuntu1204.list'
end

include_recipe 'apt'

apt_package 'tmux'

include_recipe 'git'
include_recipe 'vim'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby '1.9.3-p194' do
  global true
end

rbenv_gem 'bundler' do
  ruby_version '1.9.3-p194'
end

rbenv_gem 'rails' do
  ruby_version '1.9.3-p194'
  version '~> 4.0.0'
end

package 'libcouchbase2-core' do
  options '--force-yes'
end
package 'libcouchbase-dev' do
  options '--force-yes'
end
