class Photo < ActiveRecord::Base

    validates_presence_of :title, :link, :slideshow

    def show_created_by
        User.find_by_id(created_by)
    end

    def link=(new_value)
        valid_url = match_flickr(new_value)
        if valid_url
            new_value = embedded_flickr(valid_url.captures[3])
        end

        valid_url = match_picassa(new_value)
        if valid_url
            new_value = embedded_picasa(valid_url.captures[0], valid_url.captures[1])
        end

        write_attribute(:link, new_value)
    end

    def slideshow=(new_value)
        final_url = "#"
        
        valid_url = match_flickr new_value
        if valid_url
            final_url = flickr_slideshow(valid_url.captures[2], valid_url.captures[3])
        end

        valid_url = match_picassa new_value
        if valid_url
            final_url = picassa_slideshow(valid_url.captures[0], valid_url.captures[1])
        end

        write_attribute(:slideshow, final_url)
    end

    def flickr_slideshow userid, photoset
        "http://www.flickr.com/photos/#{userid}/sets/#{photoset}/show/"
    end

    def picassa_slideshow userid, photoset
        "http://picasaweb.google.com/#{userid}/#{photoset}#slideshow"
    end

    def embedded_flickr(setId)
        "<iframe align='center'
        src='http://www.flickr.com/slideShow/index.gne?set_id=#{setId}'
        frameBorder='0' width='400' scrolling='no' height='400'></iframe>"
    end

    def embedded_picasa(userName, albumName)

        "<embed type='application/x-shockwave-flash'
            src='http://picasaweb.google.com/s/c/bin/slideshow.swf'
            width='400' height='267'
            flashvars='host=picasaweb.google.com&autoplay=1&RGB=0x000000&feed=http%3A%2F%2Fpicasaweb.google.com%2Fdata%2Ffeed%2Fapi%2Fuser%2F#{userName}%2Falbum%2F#{albumName}%3Fkind%3Dphoto%26alt%3Drss'
            pluginspage='http://www.macromedia.com/go/getflashplayer'></embed>"
    end

    private

    def match_flickr(new_value)
        new_value.match(%r{^http://((www\.)?)flickr.com/photos/(.+)/sets/([0-9]+)((\/)?)})
    end

    def match_picassa(new_value)
        new_value.match(%r{^http://picasaweb.google.com/(.+)/([A-Za-z0-9\.]+)([#]*)})
    end



end
