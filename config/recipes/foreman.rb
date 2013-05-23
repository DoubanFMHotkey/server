namespace :foreman do
  task :setup do
    run "cd #{current_path} && rvmsudo -p 'sudo password: ' \
      bundle exec foreman export upstart /etc/init -d #{current_path} \
        -u meck -e #{current_path}/production.env -a #{application} -l #{shared_path}/log"
    run "#{sudo} sed -i '1 i start on runlevel [2345]' /etc/init/#{application}.conf"
  end

  #after "deploy:setup", "foreman:setup"

  %w[start stop restart].each do |command|
    desc "#{command} forman"
    task command, :roles => :app do
      r = capture "#{sudo} status #{application}; true"
      logger.info r
      case r
      when /.*Unknown job.*/
        setup
      else
        run "#{sudo} #{command} #{application}; true"
      end
    end
    #after "deploy:#{command}", "foreman:#{command}"
  end
end
