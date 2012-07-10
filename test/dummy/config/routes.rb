Rails.application.routes.draw do

  mount BcmsFeeds::Engine => "/bcms_feeds"
	mount_browsercms
end
