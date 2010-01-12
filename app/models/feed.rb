class Feed < ActiveRecord::Base

  def self.send_mail(params, current_user)
        FeedMailer.deliver_new_post(params, current_user)
      
  end

  def show_pub_date
      tz = TimeZone.new "Sydney"
      t = tz.utc_to_local pubDate
      t.strftime "%b %d, %Y, %I:%M:%S %p Sydney Time"
  end

  def caption
      title
  end

  def url
      "/feeds/#{id}"
  end

  def obj
      nil
  end


end
