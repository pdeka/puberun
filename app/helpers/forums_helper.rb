module ForumsHelper
  # used to know if a topic has changed since we read it last
  def recent_topic_activity(topic)
    return topic.last_updated_at > Time.now.at_beginning_of_week
  end 

  # used to know if a forum has changed since we read it last
  def recent_forum_activity(forum)
    return false unless logged_in? && forum.recent_topic
    return forum.recent_topic.last_updated_at > ((session[:forums] ||= {})[forum.id] || last_active)
  end

  def topic_count
    pluralize current_site.topics.size, 'topic'
  end
  
  def post_count
    pluralize current_site.posts.size, 'post'
  end
  
  def last_active
    session[:last_active] ||= Time.now.utc
  end
  
  # Ripe for optimization
  def voice_count
    pluralize current_site.topics.to_a.sum { |t| t.voice_count }, 'voice'
  end

end
