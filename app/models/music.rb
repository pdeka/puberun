class Music < ActiveRecord::Base

  validates_presence_of :title, :link, :music_type

  def show_created_by
      User.find_by_id(created_by)
  end

  def link=(new_value)
      valid_url = new_value.match(%r{^http://share.ovi.com/media/(.+)/(.+)})
      if valid_url
          new_value = embedded_ovi(valid_url.captures[0], valid_url.captures[1])
      end
      write_attribute(:link, new_value)
  end

  def embedded_ovi(album, song)
    "<embed src=\"http://share.ovi.com/flash/audioplayer.aspx?media=#{song}&albumname=#{album}\"
      width=\"145\" height=\"60\" type=\"application/x-shockwave-flash\"></embed>"
  end

end
