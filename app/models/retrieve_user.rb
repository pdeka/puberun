class RetrieveUser < BaseWithoutTable

    attr_accessor :email

    validates_presence_of     :email
    validates_format_of       :email,    :with => /^([-a-zA-Z0-9\._]+)@([-a-zA-Z0-9\.]+[a-z]{2,})$/

    def self.send_mail found_user
        pass = random_password
        found_user.update_attributes! :password => pass, :password_confirmation => pass
        RetrieveUserMailer.deliver_retrieve_user_email(found_user, pass)
    end

    protected

    def self.random_password(size = 8)
        chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
        (1..size).collect{|a| chars[rand(chars.size)] }.join
    end

end
