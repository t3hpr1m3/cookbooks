include_recipe 'java'
include_recipe 'elasticsearch'

execute "#{node.elasticsearch[:dir]}/elasticsearch/bin/plugin -install mobz/elasticsearch-head" do
  user 'root'
  not_if "test -d #{node.elasticsearch[:dir]}/elasticsearch/plugins/head"
end

execute "#{node.elasticsearch[:dir]}/elasticsearch/bin/plugin -install transport-couchbase -url http://packages.couchbase.com.s3.amazonaws.com/releases/elastic-search-adapter/1.2.0/elasticsearch-transport-couchbase-1.2.0.zip" do
  user 'root'
  not_if "test -d #{node.elasticsearch[:dir]}/elasticsearch/plugins/transport-couchbase"
end

execute "curl -XPUT http://localhost:9200/_template/couchbase -d @#{node.elasticsearch[:dir]}/elasticsearch/plugins/transport-couchbase/couchbase_template.json" do
  user 'root'
  not_if "test -d #{node.elasticsearch[:dir]}/config/templates/couchbase_template.json"
end

execute "#{node.elasticsearch[:dir]}/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/1.7.0" do
  user 'root'
  not_if "test -d #{node.elasticsearch[:dir]}/elasticsearch/plugins/analysis-kuromoji"
end

template "#{node.elasticsearch[:path][:conf]}/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  owner 'root'
  group 'root'
  mode '0644'
end

service 'elasticsearch' do
  action :restart
end
