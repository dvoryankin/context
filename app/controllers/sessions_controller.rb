class SessionsController < ApplicationController

  skip_before_action :login_required, only: [ :new, :create ]
  before_action :show_tasks_for_user, only: :new

  def new
    @time = Time.now
  end

  def create
    user = User.authenticate params[:email], params[:password]

    if user
      session[:user_id] = user.id
      redirect_to tasks_path, notice: 'Welcome to context'
    else
      flash.now.alert = 'Wrong email or password'
      render :new
      # redirect_to login_path
      # redirect_to controller: :sessions, action: :new
      # redirect_to 'sessions/new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You're successfully logged off"
  end

  private

  def show_tasks_for_user
    redirect_to tasks_path, notice: 'Welcome to context!' if current_user
  end
end
