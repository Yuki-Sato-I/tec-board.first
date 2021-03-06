class GroupsController < ApplicationController
  before_action :logged_in_user
  before_action :group_member, only: [:member,:index,:chat,:chat_create]

  def index
    @group = Group.find_by(id: params[:id])
  end

  def invited
    @group = Group.new
  end

  def permission
    @user = current_user
    if @group = Group.find_by(invitation_code: params[:invite][:invitation_code]) ##ここがおかしい id だとできる　invitation_code にするとダメ
      if @user.user_groups.find_by(user_id: @user.id, group_id: @group.id) != nil
        flash.now[:danger] = "すでに参加しています."
        redirect_to @user and return #returnすれば　ここで動作を終える
      end
      @user.user_groups.create(user_id: @user.id, group_id: @group.id)
      flash[:success] = "#{@group.name}に参加しました."
      redirect_to @user
    else
      flash.now[:danger] = "招待コードが間違っています."
      render 'invited'
    end
  end

  PER = 5

  def member
    @group = Group.find_by(id: params[:id])
    @members = @group.users.page(params[:page]).per(PER)
  end

  def picture
  end

  def chat 
    @user = current_user
    @chat = Chat.new
    @group = Group.find(params[:group_id])
    @chats = @group.chats

  end

  def chat_create
    @user = current_user
    @chat = @user.chats.new(chat_params)
    @group = Group.find(params[:group_id])
    @chat.group_id = @group.id
    if @chat.save
      redirect_to "/groups/#{@group.id}/chat"
    else
      flash.now[:danger] = "失敗"
      redirect_to "/groups/#{@group.id}/chat"
    end
  end

  def new
    @group = Group.new
  end

  def create
    @user = current_user
    @group = @user.groups.new(group_params)
    @group.admin_user_id = @user.id
    @group.invitation_code = SecureRandom.base64(8)
    if @group.save
      @user.user_groups.create(user_id: @user.id, group_id: @group.id)
      flash[:success] = "グループを作成しました."
      redirect_to "/groups/#{@group.id}"
    else
      render 'new'
    end
  end
  private
    def group_params
      params.require(:group).permit(:name)
    end

    def chat_params
      params.require(:chat).permit(:content)
    end
    #def invite_params
     # params.require(:group).permit(:invitation_code)
    #end #これだとうまくいかなかった　なんで？

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください."
        redirect_to login_url
      end
    end

end
