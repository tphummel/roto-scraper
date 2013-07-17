set :application, "roto-scraper"
set :application_port, 5001

set :scm, :git
set :scm_verbose, true

set :repository, "git@github.com:tphummel/#{application}.git"
set :branch, "master"

set :user, "tom"                               # user to ssh in as
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

set :node_file, "index.js"                  # this is the entry point to your app that should run as a deamon

set :deploy_to, "/home/#{user}/#{application}" 
set :deploy_via, :remote_cache
set :keep_releases, 5

set :admin_runner, 'tom'                       # user to run the application node_file as
set :application_binary, '/usr/local/bin/node'  # application for running your app. Use coffee for coffeescript apps

set :node_env, 'production'

set :sub_domain, 'roto'

set :log_file, "/var/log/#{application}.log"

default_run_options[:pty] = true

task :donaldson do
  set :branch, "master"
  set :top_level_task, "donaldson"
  set :app_host, "tphum.us"
  role :app, "198.199.109.183"
end

namespace :deploy do

  desc "Check required packages and install if packages are not installed"
  task :update_packages, roles => :app do
    run "cd #{release_path} && npm install && npm rebuild"
  end

  task :create_deploy_to, :roles => :app do
    run "mkdir -p #{deploy_to}"
  end

  desc "writes the upstart script for running the daemon. Customize to your needs"
  task :write_upstart_script, :roles => :app do
    upstart_script = <<-UPSTART
  description "#{application}"

  start on runlevel [2345]
  stop on shutdown

  script
      # We found $HOME is needed. Without it, we ran into problems
      export HOME="/home/#{admin_runner}"
      export NODE_ENV="#{node_env}"
      cd #{current_path}

      exec sudo -u #{admin_runner} sh -c "\
      APP_HOST=#{app_host} NODE_ENV=#{node_env} PORT=#{application_port} \
      #{application_binary} #{current_path}/#{node_file} \
      >> #{log_file} 2>&1"
  end script
  respawn
UPSTART
  put upstart_script, "/tmp/#{application}_upstart.conf"
    run "sudo mv /tmp/#{application}_upstart.conf /etc/init/#{application}.conf"
  end

  desc "writes the nginx config for proxying to node"
  task :write_nginx_config, :roles => :app do
    nginx_config = <<-NGINX
server {
  listen 80;
  server_name #{sub_domain}.#{app_host};

  location / {
    proxy_set_header Host $http_host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-M-Secure "true";
    proxy_redirect off;
    proxy_max_temp_file_size 0;
    proxy_pass http://127.0.0.1:#{application_port};
  }
}
NGINX
    put nginx_config, "/tmp/#{application}_nginx_config"
    run "sudo mv /tmp/#{application}_nginx_config /etc/nginx/sites-enabled/#{application}"
  end
  
  task :touch_log, :roles => :app do
    run "sudo touch #{log_file}"
    run "sudo chown #{user}:#{user} #{log_file}"
  end

  desc "Update submodules"
  task :update_submodules, :roles => :app do
    run "cd #{release_path}; git submodule init && git submodule update"
  end

  desc "create deployment directory"
  task :create_deploy_to, :roles => :app do
    run "mkdir -p #{deploy_to}"
  end

end

namespace :config do
  desc "create shared/config directory"
  task :create_dir, :roles => :app do
    run "mkdir -p #{shared_path}/config"
  end

  desc "make symlink for config/creds.coffee"
  task :create_symlink, :roles => :app do
    run "ln -nfs #{shared_path}/config/creds.coffee #{release_path}/config/creds.coffee"
  end
end

namespace :node_modules do
  desc "create node modules directory"
  task :create_dir, :roles => :app do
    run "mkdir -p #{shared_path}/node_modules"
  end

  desc "make symlink for node modules"
  task :create_symlink, :roles => :app do
    run "ln -nfs #{shared_path}/node_modules #{release_path}/node_modules"
  end
end

namespace :git do

  desc "Delete remote cache"
  task :delete_remote_cache do
    run "rm -rf #{shared_path}/cached-copy"
  end

end

before 'deploy:setup', 'deploy:create_deploy_to'
after 'deploy:setup', 'node_modules:create_dir', 'config:create_dir','deploy:write_upstart_script', 'deploy:write_nginx_config', 'deploy:touch_log'

after "deploy:finalize_update", "node_modules:create_symlink", "config:create_symlink", "deploy:update_submodules", "deploy:update_packages"