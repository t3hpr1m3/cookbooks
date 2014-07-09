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

directory '/mnt/engines' do
  owner 'vagrant'
  action :create
end

unless node['moses_installed']

  package "libboost-dev"
  package "libboost-thread-dev"
  package "libxmlrpc-c++4-dev"
  package "nodejs"

  {
    'irstlm_50.50.01-1_amd64.deb' => '4a41dea576fc3cb7211e66a40f40001d6684a6fac8b769b320c8e3f8d982eaf0',
    'moses_0.firma8-1_amd64.deb' => '8f004aadb91e6d70f27599e5ab5870b8b20468b28416684f987567f845b8d365',
  }.each do |file, sha|
    remote_file "/var/chef/cache/#{file}" do
      action :create
      source "http://s3.chef.firma8.com/moses/#{file}"
      checksum sha
    end
    execute "install #{file[/^[^_]+/]}" do
      action :run
      command "dpkg -i #{file}"
      user 'root'
      cwd '/var/chef/cache'
    end
  end

  execute "create elasticsearch index" do
    action :run
    command "curl -XPUT 'http://localhost:9200/tokenizer/'"
    returns (0..200).to_a
  end if node['recipes'].include?('elasticsearch')

  node.set['moses_installed'] = true
end

#package 'libcouchbase2-core' do
#  options '--force-yes'
#end
#package 'libcouchbase-dev' do
#  options '--force-yes'
#end
