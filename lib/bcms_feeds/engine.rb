require 'browsercms'
module BcmsFeeds
  class Engine < ::Rails::Engine
    isolate_namespace BcmsFeeds
    include Cms::Module
  end
end
