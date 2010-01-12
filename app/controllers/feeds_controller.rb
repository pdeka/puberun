class FeedsController < ApplicationController

  before_filter :login_required, :only => [ :new, :index, :create ]
  before_filter :group_membership_required, :only => [ :new, :index, :create ]

  layout 'application'

  def new
  end
  
  def index
    find_feed

    respond_to do |format|
      format.html { render :layout => 'application'}
      format.xml  { render :xml => @feeds }
    end
  end

  def create
    find_feed

    if valid params
      Feed.send_mail params, current_user
    end

    redirect_to "/feeds"
    flash[:notice] = "Your email has been sent to the group.
                          It will appear on this site after 5-10 mins."

  rescue
    flash[:error] = "I cannot send your mail as an unknown error occured during send.
                            Can you please check various things?
                            1. Are you sure you are in the groups mailing lists?
                            2. Are you connected to the network? 
                            If the problem persists please mail or call support."
    redirect_to "/feeds"

  end

  private

  def valid params

    if params[:subject] == "" or params[:body] == ""
      flash[:error] = 'I cannot send your mail as the subject or body is empty!'
      return false
    end

    return true
  end

  def find_feed
    @feeds = Feed.find(:all, :limit => "20", :order => "pubDate DESC")
  end

end
