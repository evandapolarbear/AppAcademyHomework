class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create, :landing]

  def landing
    render :landing_page
  end

  def new
    render :new
  end

  def show
    render :show
    # Todo: make it so show renders indiv user/ their email
  end

  def create
    user = User.new(user_params)

    if user.valid?
      user.save!
      session[:session_token] = user.session_token
      #Need to decide where to redirect to once a user is logged in
    else
      fash.now[:errors] = user.errors.full_messages
      redirect  new_user_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :session_token)
  end
end
