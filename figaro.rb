namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :copy do
    transfer :up, "config/application.yml", "#{shared_path}/application.yml", via: :scp
  end
  after "deploy:setup", "figaro:copy"
 
  desc "Symlink application.yml to the release path"
  task :finalize do
    run "ln -sf #{shared_path}/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "figaro:finalize"
end
