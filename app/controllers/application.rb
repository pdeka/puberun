# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper :all
  helper_method :current_page
  helper_method :config

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e125a4be589f9d81263920581f6e4182'

  # raised in #current_site
  rescue_from Site::UndefinedError do |e|
    redirect_to new_site_path
  end

  def current_page
    @page ||= params[:page].blank? ? 1 : params[:page].to_i
  end

  def config
    @@config = Enki::Config.new("#{RAILS_ROOT}/config/puberun.yml")
  end

end
