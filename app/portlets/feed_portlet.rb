class FeedPortlet < Cms::Portlet
  handler "erb"
  
  enable_template_editor true
  
  def render
    raise ArgumentError, "No feed URL specified" if self.url.blank?
    @feed = BcmsFeeds::Feed.find_or_create_by_url(self.url).parsed_contents
    if @portlet.limit.to_i != 0
      @items = @feed.items[0..(@portlet.limit.to_i - 1)]
    else
      @items = @feed.items
    end
    instance_eval(self.code) unless self.code.blank?
  end

end
