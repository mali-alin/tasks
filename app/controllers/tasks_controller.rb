class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  before_action :set_task, only: [:show]
  before_action :set_current_user_task, only: [:edit, :update, :destroy]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit

  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created'
    else
      render 'new'
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was sucessfully updated'
    else
      render :edit
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def transit_in_progress
    @task.start
    redirect_to tasks_url, notice: 'Task has been started'
  end

  private

  def set_current_user_task
    @task = current_user.tasks.find(params[:id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :deadline)
  end
end
