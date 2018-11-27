class BoardsController < ApplicationController
  before_action :logged_in_user
  PER = 5
  def index
    @group = Group.find_by(id: params[:group_id])
    @boards = @group.boards.page(params[:page]).per(PER)
  end

  def show
    @group = Group.find(params[:group_id])
    @board = @group.boards.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @group = Group.find_by(id: params[:group_id])
    @board = @group.boards.new(board_params)
    @board.group_id = @group.id 
    if @board.save
      flash[:success] = "掲示を作成しました."
      redirect_to "/boards/#{params[:group_id]}/index"
    else
      render 'new'
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @board = @group.boards.find(params[:id])
    if @board.update_attributes(board_params)
      flash[:success] = "編集が完了しました."
      redirect_to "/boards/#{@group.id}/show/#{@board.id}"
    else
      render 'edit'
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @board = @group.boards.find(params[:id])
  end

  def destroy
    @group = Group.find_by(id: params[:group_id])
    @board = @group.boards.find(params[:id])
    @board.destroy
    redirect_to "/boards/#{params[:group_id]}/index"
  end

  private
    def board_params
      params.require(:board).permit(:content,:title)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください."
        redirect_to login_url
      end
    end
end
