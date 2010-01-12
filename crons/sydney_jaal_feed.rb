#!/usr/local/bin/ruby

require 'net/http'
require 'rexml/document'
require 'rubygems'
require 'activerecord'

def parse_time string_time
    if string_time.nil? or string_time == ""
        Time.now.getgm
    else
        Time.parse(string_time).getgm
    end
end


puts "running job to get sydney jaal content at - #{Time.now}"
ActiveRecord::Base.establish_connection(
        :adapter  => "mysql",
                :host     => "localhost",
                :username => "pdeka",
                :password => "deca10",
                :database => "pdeka_puberun"
)

class Feed < ActiveRecord::Base
end

feed = Net::HTTP.get('rss.groups.yahoo.com', '/group/sydney_jaal/rss')
feeds = REXML::Document.new feed

feeds.elements.each("rss/channel/item") { |item|
    @feed = Feed.new
    item.elements.each { |elem|
        if elem.name == "title"
            @feed.title = elem.text
        elsif elem.name == "pubDate"
            @feed.pubDate = parse_time elem.text
        elsif elem.name == "description"
            @feed.description = elem.text
        elsif elem.name == "link"
            @feed.link = elem.text
        elsif elem.name == "creator"
            @feed.creator = elem.text
        elsif elem.name == "guid"
            @feed.guid = elem.text
        end
    }
    if Feed.find_by_guid(@feed.guid).nil?
        @feed.save!
    end
}

