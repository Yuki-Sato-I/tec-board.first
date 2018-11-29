class HomeController < ApplicationController
  def top
    if current_user
      redirect_to users_path
    end
  end

  def about
  end

  def terms_of_service
  end

  def policy
  end
end
