class TasksController < ApplicationController
  def new
  end

  def index
    @tasks = current_user.tasks.free.incomplete.recent(5)
  end

  def show
  end
end
