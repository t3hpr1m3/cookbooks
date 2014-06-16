default['mysql']['server_root_password'] = 'foobar'
default['mysql']['server_repl_password'] = 'foobar'
default['mysql']['server_debian_password'] = 'foobar'
default['java']['install_flavor'] = 'openjdk'
default['java']['jdk_version'] = '7'

default['rbenv']['user_installs'] = [
  {
    'user' => 'vagrant',
    'rubies' => ['1.9.3-p194'],
    'global' => '1.9.3-p194'
  }
]
