include_recipe 'nginx'

template "#{node.nginx.dir}/sites-available/couchbase.conf" do
  source "couchbase.conf.erb"
  mode "0644"
end

nginx_site "couchbase.conf"
