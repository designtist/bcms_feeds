# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bcms_feeds/version"

Gem::Specification.new do |s|
  s.name = %q{bcms_bmedia_feeds}
  s.version = BcmsFeeds::VERSION 

  s.authors = ["Jon Leighton", "BrowserMedia"]
  s.description = %q{A BrowserCMS module which fetches, caches and displays RSS/Atom feeds}
  s.email = %q{github@browsermedia.com}

  s.homepage = "http://www.github.com/browsermedia/bcms_feeds" 
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{Feeds in BrowserCMS}
  s.extra_rdoc_files = ["README.markdown"]
  
  s.files = Dir["{app,config,db,lib}/**/*"]
  s.files += Dir["Gemfile", "LICENSE.txt", "COPYRIGHT.txt", "GPL.txt" ]

  s.add_dependency("browsercms", "< 3.6.0", ">= 3.5.0")
  s.add_dependency("simple-rss", "~> 1.2.3")

end
