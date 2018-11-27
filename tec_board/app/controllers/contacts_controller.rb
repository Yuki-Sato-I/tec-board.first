class ContactsController < ApplicationController
  before_action :admin_user, only: [:destroy,:index]
  PER = 5
  def index
    @contacts = Contact.all.page(params[:page]).per(PER)
  end
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "送信しました."
      redirect_to '/contacts/new'
    else
      render 'new'
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to '/contacts/index'
  end


  private
    def contact_params
      params.require(:contact).permit(:questioner_name, :questioner_email,:content)
    end
    
    def admin_user
      if current_user
        if current_user.admin
        else
          flash[:danger] = "権限がありません."
          redirect_to(current_user)
        end
      else
        redirect_to '/'
      end
    end

end
