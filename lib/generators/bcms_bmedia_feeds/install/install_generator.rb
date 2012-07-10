require 'cms/module_installation'

module BcmsBmediaFeeds
end
class BcmsBmediaFeeds::InstallGenerator < Cms::ModuleInstallation
  add_migrations_directory_to_source_root __FILE__
  
  
  def copy_migrations
    rake 'bcms_feeds:install:migrations'
  end

  # Uncomment to add module specific seed data to a project.
  #def add_seed_data_to_project
  #  copy_file "../bcms_feeds.seeds.rb", "db/bcms_feeds.seeds.rb"
  #  append_to_file "db/seeds.rb", "load File.expand_path('../bcms_feeds.seeds.rb', __FILE__)\n"
  #end
  
  def add_routes
    mount_engine(BcmsFeeds)
  end
    
end