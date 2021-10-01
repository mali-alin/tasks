class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  # GET /tasks or /tasks.json
  def index
    @new_tasks = Task.where(status: :new)
    @in_progress_tasks = Task.where(status: :in_progress)
    @completed_tasks = Task.where(status: :completed)
    @canceled_tasks = Task.where(status: :canceled)
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @task = task
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit
    return redirect_to task_path(task) unless avaliable?
  end

  def start
    return redirect_to task_path(task), alert: 'dasdas' unless task.can_start?

    task.start!

    redirect_to tasks_path
  end

  def complete
    return redirect_to task_path(task), alert: 'need 2 approvals' unless task.can_complete?

    task.complete!

    redirect_to tasks_path
  end

  def cancel
    task.cancel!

    redirect_to tasks_path
  end

  # POST /tasks or /tasks.json
  def create
    task = current_user.tasks.build(create_params)

    if task.save
      redirect_to task_path(task.id), notice: 'Task was successfully created'
    else
      render 'new'
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if task.update(update_params)
      redirect_to task_path, notice: 'Task was sucessfully updated'
    else
      render :edit
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    task.delete

    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def task
    @task = Task.find(params[:id])
  end

  def create_params
    params.require(:task).permit(:name, :deadline)
  end

  def update_params
    params.require(:task).permit(:name, :deadline)
  end

  def avaliable?
    task.in?(current_user.tasks)
  end
end
