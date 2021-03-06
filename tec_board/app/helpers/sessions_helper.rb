module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    flash[:success] = "ログインしました."
  end

  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember,cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end


  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = "ログアウトしました."
  end
  def current_user?(user)
    user == current_user
  end
    
  # group member以外入れない
  def group_member
    if params[:group_id]
      group = Group.find_by(id: params[:group_id])
    else
      group = Group.find_by(id: params[:id])
    end

    if group == nil
      redirect_to current_user and return
    end

    if group.user_groups.find_by(user_id: current_user.id)
    else
      redirect_to current_user
    end
  end
end
