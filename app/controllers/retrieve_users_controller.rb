class RetrieveUsersController < ApplicationController

    layout "application"

    def new
        @retrieve_user = RetrieveUser.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @retrieve_user }
        end
    end


    def create
        @retrieve_user = RetrieveUser.new(params[:retrieve_user])

        if !@retrieve_user.save
            flash[:error] = 'Email id not valid. Note that it has to be the email address you signed up with. Email address needs to something like mrinalpatua@bigpaunch.com'
            raise
        end

        this_user = find_user @retrieve_user

        if this_user.nil?
            flash[:error] = "I could not find the user with the given email id. Are you sure you are signed in with the email id you just entered."
            raise
        end

        RetrieveUser.send_mail this_user

        flash[:notice] = "An email has been sent to with your username and password."
        redirect_to new_retrieve_user_path

    rescue
        if flash[:error].nil?
            flash[:error] = "I cannot send your mail as an unknown error occured during send.
                        Are you connected to the network?
                        If the problem persists please mail or call support."
        end
        redirect_to new_retrieve_user_path

    end


    protected

    def find_user retrieve_user
        @feeds = User.find(:first, :conditions => "email = '#{retrieve_user.email}'")
    end

end
