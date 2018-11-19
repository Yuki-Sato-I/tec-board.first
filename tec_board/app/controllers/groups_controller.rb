class GroupsController < ApplicationController
  def index
    @group = Group.find_by(id: params[:id])
  end

  def board
  end

  def member
  end

  def picture
  end

  def chat
  end

  def new
    @group = Group.new
  end

  def create
    @user = current_user
    @group = @user.groups.new(group_params)
    @group.admin_user_id = @user.id
    if @group.save
      @user.user_groups.create(user_id: @user.id, group_id: @group.id)
      flash[:success] = "グループを作成しました."
      redirect_to "/groups/#{@group.id}"
    else
      flash[:danger] = "グループ作成に失敗しました."
      redirect_to user_path(current_user)
    end
  end
  private
    def group_params
      params.require(:group).permit(:name)
    end
end
