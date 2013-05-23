require "bundler/capistrano"
set :rvm_ruby_string, :local
set :rvm_autolibs_flag, "read-only"
before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'
before 'deploy:setup', 'rvm:create_gemset'
require "rvm/capistrano"

set :application, 'douban-fm-hotkey-server'
set :repository,  'git@gitlab.com:yesmeck/douban-fm-hotkey-server.git'
set :scm, :git
set :deploy_via, :remote_cache
set :user, 'meck'
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :keep_releases, 5
set :port, 64
set :domain_name, 'douban.yesmeck.com'
set :stage, :production

server domain_name, :app, :web, :db, :primary => true

default_run_options[:pty] = true

after "deploy:restart", "deploy:cleanup"

