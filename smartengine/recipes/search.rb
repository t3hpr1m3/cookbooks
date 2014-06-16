include_recipe 'java'
include_recipe 'elasticsearch'

execute "#{node.elasticsearch[:dir]}/elasticsearch/bin/plugin -install mobz/elasticsearch-head" do
  user 'root'
  not_if "test -d #{node.elasticsearch[:dir]}/elasticsearch/plugins/head"
end

execute "#{node.elasticsearch[:dir]}/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/2.2.0" do
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
