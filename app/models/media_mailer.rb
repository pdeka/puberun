class MediaMailer < ActionMailer::Base

  def email this_media, user, config
    setup_email config
    default_url_options[:host] = "#{config[:default_host]}"

    @subject    = "[Puberun] New #{this_media.class.name} added - #{this_media.title}"
    @body[:title]  = this_media.title
    @body[:userName]  = user.show_display_name
    @body[:media]  = this_media.class.name
  end

  protected

  def setup_email config
    @recipients  = "#{config[:media_mailer_recipient]}"
    @from        = "#{config[:mailer_from]}"
    @sent_on     = Time.now
  end
end
