class AlbumsController < ApplicationController
  before_action :logged_in_user
  before_action :group_member

  PER = 5
  def index
    @group = Group.find_by(id: params[:group_id])
    @albums = @group.albums.page(params[:page]).per(PER)
  end

  def show
    @group = Group.find_by(id: params[:group_id])
    @album = @group.albums.find(params[:id])
  end

  def edit
    @group = Group.find(params[:group_id])
    @album = @group.albums.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @album = @group.albums.find(params[:id])
    if @album.update(album_param)
      flash[:success] = "編集が完了しました."
      redirect_to "/albums/#{@group.id}/show/#{@album.id}"
    else
      render 'edit'
    end
  end

  def new
    @album = Album.new
  end

  def create
    @group = Group.find(params[:group_id])
    @album = @group.albums.new(album_params)
    if @album.save
      flash[:success] = "アルバムを作成しました."
      redirect_to "/albums/#{params[:group_id]}/index"
    else
      render 'new'
    end
  end

  def destroy
    @group = Group.find_by(id: params[:group_id])
    @album = @group.albums.find(params[:id])
    @album.destroy
    redirect_to "/albums/#{params[:group_id]}/index"
  end

  private
    def album_params
      params.require(:album).permit(:title,:content,{images: []})
    end
    def album_param
      params.require(:album).permit(:title,:content)
    end 
end
