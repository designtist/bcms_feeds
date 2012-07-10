Feed Module
==========

This is a fork of https://github.com/jonleighton/bcms_feeds which updates the module to work with BrowserCMS 3.5.x and later. It will be released as bcms_bmedia_feeds since the original gem is owned by jonleighton.

Overview
========

This is a BrowserCMS module which fetches, caches and displays RSS/Atom feeds.

Installation
============

For installation instructions see http://www.browsercms.org/doc/guides/html/installing_modules.html

	$ gem install bcms_bmedia_feeds
	$ rails g cms:install bcms_bmedia_feeds
	
To incorporate a feed in your page, add a Feed Portlet to a page. Specify the URL of the feed. You can use the code section to manipulate this data as necessary, and the template to format it. SimpleRSS [http://simple-rss.rubyforge.org/] is used for parsing, and a parsed version of the feed will be available in the @feed variable.

Feeds are cached in the database for 30 minutes. If there is a failure fetching a remote feed, the expiry time of the cached feed will be extended by 10 minutes. When fetching remote feeds, the timeout length is 10 seconds.

Issues
=====

* Escaping html - Feeds will often use HTML in their post bodies. If you decide the 3rd party site is 'trustworthy' enough to just render unescaped HTML from their site on, then you can unescape the XML. By default, its contents are shown as XML encoded bodies. 
* Cached Pages - If a page with a feed portlet on it has been cached, it will not update with as much frequency as might be expected. You can solve this by turning off page caching for that page.