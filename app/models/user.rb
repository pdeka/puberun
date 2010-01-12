class User < ActiveRecord::Base
  concerned_with :validation, :states, :activation, :posting
  formats_attributes :bio

  attr_accessible :website, :display_name, :avatar
  
  has_attached_file :avatar

  belongs_to :site, :counter_cache => true
  validates_presence_of :site_id
  
  has_many :posts, :order => "#{Post.table_name}.created_at desc"
  has_many :topics, :order => "#{Topic.table_name}.created_at desc"
  
  has_many :moderatorships, :dependent => :delete_all
  has_many :forums, :through => :moderatorships, :source => :forum

  has_many :monitorships, :dependent => :delete_all
  has_many :monitored_topics, :through => :monitorships, :source => :topic, :conditions => {"#{Monitorship.table_name}.active" => true}
  
  has_permalink :login
  
  attr_readonly :posts_count, :last_seen_at

  validates_attachment_size :avatar,  :in => 1..100000, :message => 'size must be between 1KB and 100KB.'
  
  def self.prefetch_from(records)
    find(:all, :select => 'distinct *', :conditions => ['id in (?)', records.collect(&:user_id).uniq])
  end
  
  def self.index_from(records)
    prefetch_from(records).index_by(&:id)
  end

  def available_forums
    @available_forums ||= site.ordered_forums - forums
  end

  def moderator_of?(forum)
    admin? || Moderatorship.exists?(:user_id => id, :forum_id => forum.id)
  end

  def show_display_name
    n = read_attribute(:display_name)
    n.blank? ? login : n
  end
  
  # this is used to keep track of the last time a user has been seen (reading a topic)
  # it is used to know when topics are new or old and which should have the green
  # activity light next to them
  #
  # we cheat by not calling it all the time, but rather only when a user views a topic
  # which means it isn't truly "last seen at" but it does serve it's intended purpose
  #
  # This is now also used to show which users are online... not at accurate as the
  # session based approach, but less code and less overhead.
  def seen!
    now = Time.now.utc
    self.class.update_all ['last_seen_at = ?', now], ['id = ?', id]
    write_attribute :last_seen_at, now
  end
  
  def to_param
    permalink
  end
end
