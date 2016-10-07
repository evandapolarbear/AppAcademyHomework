class SessionsController < ApplicationController
before_action :require_login, except: [:new, :create]

  def create
    user = User.find_user_by_credentials(params[:user][:username],
    if user
      params[:user][:password])
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to user_url(user.id)
    else
      flash[:errors] = "incorrect username/password"
      redirect_to new_session_url
    end
  end

  def new
    #renders the  login form
    render :new
  end

  def destroy
    session[:session_token] = nil
    user.reset_session_token!
    redirect_to new_session_url
  end
end
