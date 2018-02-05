class UsersController < ApplicationController

  # skip_before_action :login_required, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    permitted = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.new permitted

    if @user.save
      redirect_to tasks_path, notice: 'Welcome to context'
    else
      render :new
    end
  end

end
