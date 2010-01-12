# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

    def new
    end

    def create
        reset_session
        self.current_user = current_site.users.authenticate(params[:login], params[:password])
        if logged_in?
            if params[:remember_me] == "1"
                current_user.remember_me
                cookies[:auth_token] = { :value => current_user.remember_token, :expires => current_user.remember_token_expires_at }
            end
            redirect_to("/notes")
        else
            flash[:error] = 'User id or password is not valid. Please try again. If the problem persists call or mail support.'
            redirect_to new_session_path
        end
    end

    def destroy
        current_user.forget_me if logged_in?
        cookies.delete :auth_token
        reset_session
        redirect_to("/notes")
        session[:return_to] = nil
    end
end
