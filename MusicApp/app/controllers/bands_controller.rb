class BandsController < ApplicationController
before_action :require_login

  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
    @albums = @band.albums
  end

  def new
    render :new
  end

  def create
    band = Band.new(user_params)
    if band.valid?
      band.save!
      redirect_to root_url
    else
      flash.now[:errors] = "invalid band name!"
      render new_band_url
    end
  end

  def destroy
    Band.delete(params[:id])
    redirect_to root_url
  end

  private
  def user_params
    params.require(:band).permit(:name)
  end
end
