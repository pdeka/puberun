class FeedMailer < ActionMailer::Base

    def new_post(params, current_user)
        setup_email(current_user)
        default_url_options[:host] = 'puberun.org.au'

        @subject    = params[:subject]
        @body[:mail_body]  = params[:body]
    end

    protected

    def setup_email(current_user)
        @recipients  = "sydney_jaal@yahoogroups.com"
        @from        = "#{current_user.email}"
        @sent_on     = Time.now
    end
end
