namespace :app do

  desc "things I need to do after deploy:setup"
  task :setup_config, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    template 'application.yml', "#{shared_path}/config/application.yml"
    puts "Now edit #{shared_path}/config/application.yml"
  end
  after "deploy:setup", "app:setup_config"

  task :symlink_config, :roles => :app do
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "app:symlink_config"

end
