class Note < ActiveRecord::Base

    def caption
        title
    end

    def url
        "/notes/#{id}"
    end

    def obj
        nil
    end

end
