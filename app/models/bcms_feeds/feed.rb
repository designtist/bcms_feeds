require 'net/http'
require 'timeout'
require 'simple-rss'

module BcmsFeeds
  class Feed < ActiveRecord::Base
    TTL = 30.minutes
    TTL_ON_ERROR = 10.minutes
    TIMEOUT = 10 # In seconds
  
    delegate :entries, :items, :to => :parsed_contents
    attr_accessible :url, :contents, :expires_at
  
    def parsed_contents
      @parsed_contents ||= SimpleRSS.parse(contents)
    end
  
    def contents
      if expires_at.nil? || expires_at < Time.now.utc
        begin
          self.expires_at = Time.now.utc + TTL
          new_contents = remote_contents
          SimpleRSS.parse(new_contents) # Check that we can actually parse it
          write_attribute(:contents, new_contents)
          save
        rescue StandardError, Timeout::Error, SimpleRSSError => exception
          logger.error("Loading feed #{url} failed with #{exception.inspect}")
          self.expires_at = Time.now.utc + TTL_ON_ERROR
          save
        end
      else
        logger.info("Loading feed from cache: #{url}")
      end
      read_attribute(:contents)
    end

    def remote_contents
      Timeout.timeout(TIMEOUT) {
        simple_get(url)
      }
    end

    private

    def simple_get(url)
      logger.info("Loading feed from remote: #{url}")
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.request_get(uri.request_uri, 'User-Agent' => "BrowserCMS bcms_feed extension")

      if response.is_a?(Net::HTTPSuccess)
        return response.body
      elsif response.is_a?(Net::HTTPRedirection)
        redirect_url = response.header['Location']
        logger.info("#{url} returned a redirect. Following #{redirect_url} ")
        simple_get(redirect_url)
      else
        logger.info("An expected response type occured for #{response.code}.")
        raise StandardError 
      end
    end
  end
end
