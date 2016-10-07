class TracksController < ApplicationController
  before_action :require_login
  def new
    render :new
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    album_id = Track.find(params[:id]).album_id
    Track.delete(params[:id])
    redirect_to album_url(album_id)
  end

  def create
    track = Track.new(name: params[:track][:name], album_id: params[:album][:id])
    track.save!
    redirect_to album_url(params[:album][:id])
  end
end
