require 'md5'
require 'digest/sha1'

module ApplicationHelper
  def feed_icon_tag(title, url)
    (@feed_icons ||= []) << { :url => url, :title => title }
    link_to image_tag('feed-icon.png', :size => '14x14', :alt => "Subscribe to #{title}"), url
  end

  def pagination(collection)
    if collection.page_count > 1
      "<p class='pages'>" + 'Pages'[:pages_title] + ": <strong>" + 
      will_paginate(collection, :inner_window => 10, :next_label => "next"[], :prev_label => "previous"[]) +
      "</strong></p>"
    end
  end
  
  def next_page(collection)
    unless collection.current_page == collection.page_count or collection.page_count == 0
      "<p style='float:right;'>" + link_to("Next page"[], { :page => collection.current_page.next }.merge(params.reject{|k,v| k=="page"})) + "</p>"
    end
  end

  def search_posts_title
    returning(params[:q].blank? ? 'Recent Posts'[] : "Searching for"[] + " '#{h params[:q]}'") do |title|
      title << " "+'by {user}'[:by_user,h(@user.display_name)] if @user
      title << " "+'in {forum}'[:in_forum,h(@forum.name)] if @forum
    end
  end

  def topic_title_link(topic, options)
    if topic.title =~ /^\[([^\]]{1,15})\]((\s+)\w+.*)/
      "<span class='flag'>#{$1}</span>" + 
      link_to(h($2.strip), forum_topic_path(@forum, topic), options)
    else
      link_to(h(topic.title), forum_topic_path(@forum, topic), options)
    end
  end

  def ajax_spinner_for(id, spinner="spinner.gif")
    "<img src='/images/#{spinner}' style='display:none; vertical-align:middle;' id='#{id.to_s}_spinner'> "
  end

  def avatar_for(user, size=32)
    image_tag user.avatar.url(:original), :size => "#{size}x#{size}", :class => 'photo'
  end

  def search_path(atom = false)
    options = params[:q].blank? ? {} : {:q => params[:q]}
    prefix = 
      if @topic
        options.update :topic_id => @topic, :forum_id => @forum
        :forum_topic
      elsif @forum
        options.update :forum_id => @forum
        :forum
      elsif @user
        options.update :user_id => @user
        :user
      else
        :search
      end
    atom ? send("formatted_#{prefix}_posts_path", options.update(:format => :atom)) : send("#{prefix}_posts_path", options)
  end

  @@default_jstime_format = "%d %b, %Y %I:%M %p"
  def jstime(time, format = nil)
    content_tag 'span', time.strftime(format || @@default_jstime_format), :class => 'time'
  end

  def for_moderators_of(record, &block)
    moderator_of?(record) && concat(capture(&block), block.binding)
  end
                                    
  def redirect_to_blog this_user
    if logged_in?
     token = Digest::SHA1.hexdigest("--wtf--")
     return "#{config[:blog]}?username=#{CGI.escape(this_user.show_display_name)}&token=#{token}"
    else 
     return config[:blog]
    end
  end
end
