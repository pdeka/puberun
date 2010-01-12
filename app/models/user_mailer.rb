class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    default_url_options[:host] = 'puberun.org.au'

    @body[:url]  = activate_url(user.activation_code)
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = root_url
  end

  protected

  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "dakghar@puberun.org.au"
    @subject     = "[Puberun]"
    @sent_on     = Time.now
    @body[:user] = user
  end
end
