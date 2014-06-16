remote_file '/etc/apt/sources.list.d/couchbase.list' do
  source 'http://packages.couchbase.com/ubuntu/couchbase-ubuntu1204.list'
  notifies :run, 'execute[apt-get update]', :immediately
end

include_recipe 'ruby_build'
include_recipe 'rbenv::user'
include_recipe 'java'
include_recipe 'mysql::server'
include_recipe 'mysql::client'

[
  'libpq-dev',
  'libsqlite3-dev'
].each do |p|
  package p
end

#package 'libcouchbase2-core' do
#  options '--force-yes'
#end
#package 'libcouchbase-dev' do
#  options '--force-yes'
#end
