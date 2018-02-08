class TasksController < ApplicationController
  def new
  end

  def index
    @tasks = current_user.tasks.free.incomplete.recent(5)
  end

  def create
    permitted = params.permit(:content)
    @task = current_user.tasks.build permitted
    render json: { success: @task.save, id: @task.id }
  end

  def show
  end
end
