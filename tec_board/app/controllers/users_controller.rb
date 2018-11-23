class UsersController < ApplicationController
  before_action :logged_in_user,only:[:edit,:update,:index,:destroy]
  before_action :correct_user, only:[:edit,:update]
  before_action :admin_user, only: :destroy
  PER = 5
  def index
    @users = User.page(params[:page]).per(PER)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # @user.image_name = "default.jpg"
    #if @user.id == "1"  ###最初に登録したものを管理者にする　まだsaveしてないから無理
     #@user.update_attribute(admin: true)
    #end
    if @user.save
      log_in(@user)
      flash[:success] = "TecBoardへようこそ!!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_param)
      flash[:success] = "編集が完了しました."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "削除しました."
    redirect_to users_url
  end


  private
    def user_param
      params.require(:user).permit(:name,:image_name)
    end
    
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation,:image_name) #4つだけ許可
    end

    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください."
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(current_user) unless current_user?(@user)
    end
    # 管理者かどうか確認
    def admin_user
      redirect_to("/") unless current_user.admin?
    end

end
