include_recipe 'nginx'

template "#{node.nginx.dir}/sites-available/elasticsearch.conf" do
  source "elasticsearch.conf.erb"
  mode "0644"
end

nginx_site "elasticsearch.conf"
