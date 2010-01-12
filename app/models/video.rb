class Video < ActiveRecord::Base
    validates_presence_of :title, :link

    def show_created_by
        User.find_by_id(created_by)
    end

    def link=(new_value)
        valid_url = new_value.match(%r{http://.+\.youtube.com/watch\?v=(.+)})
        if valid_url
            new_value = embedded_youtube(valid_url.captures[0])
        end
        write_attribute(:link, new_value)
    end

    def embedded_youtube(video_id)
        "<object width=\"425\" height=\"344\">
            <embed src=\"http://www.youtube.com/v/#{video_id}&hl=en&fs=1\" type=\"application/x-shockwave-flash\"
            allowscriptaccess=\"always\" allowfullscreen=\"true\" width=\"425\" height=\"344\"></embed>
         </object>"
    end
end