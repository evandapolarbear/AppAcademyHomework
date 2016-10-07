class AlbumsController < ApplicationController
  before_action :require_login
  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
  end

  def new
    flash[:band_id] = params[:band_id]
    render :new
  end

  def create
    album = Album.new(name: params[:album][:name], band_id: flash[:band_id])

    if album.valid?
      album.save!
      album_post_save = Album.last
      redirect_to band_url(flash[:band_id])
    else
      redirect_to band_url(flash[:band_id])

      #needs a more robust redirect system
    end
  end

  def destroy
    band_id = Album.find(params[:id]).band_id
    Album.delete(params[:id])
    redirect_to band_url(band_id)
  end

  private
  def user_params
    params.require(:album).permit(:name, :band_id)
  end
end
