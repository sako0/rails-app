class UsersController < ApplicationController
  layout "default", only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:user][:terms] == "1"
      if @user.save && Profile.create(user_id: @user.id)
        @user.send_activation_email
        flash[:info] = "確認用のメールを送りました。ご確認の上、記載のリンクをクリックしてください。"
        redirect_to new_user_path
      else
        flash[:danger] = @user.errors.full_messages.to_s.gsub(",", "<br>").gsub("[", "").gsub("]", "").gsub('"', "").html_safe
        redirect_to new_user_path
      end
    else
      flash[:info] = "利用規約に同意していません。"
      redirect_to new_user_path
    end

  end

  def home
    if logged_in?
      @current_user = current_user
      @microposts = current_user.microposts
    else
      redirect_to new_session_path
    end
  end

  def index
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.build
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
