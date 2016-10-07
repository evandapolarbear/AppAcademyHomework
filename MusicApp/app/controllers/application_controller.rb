class ApplicationController < ActionController::Base

  # protect_from_forgery with: :exception


  def logged_in?
    if !@current_user.nil?
      current_user.session_token == session[:session_token]
    end
    false
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_login
    redirect_to not_logged_in_url unless logged_in?
  end

end
