class RetrieveUserMailer < ActionMailer::Base

    def retrieve_user_email(found_user, new_pass)
        setup_email(found_user)
        default_url_options[:host] = 'puberun.org.au'

        @subject    = '[Puberun] Your account details including username and password'
        @body[:user]  = found_user
        @body[:password]  = new_pass
    end

    protected

    def setup_email(found_user)
        @recipients  = found_user.email
        @from        = "dakghar@puberun.org.au"
        @sent_on     = Time.now
    end
end
