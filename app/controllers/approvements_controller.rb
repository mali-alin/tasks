class ApprovementsController < ApplicationController
   before_action :set_task, only: [:create, :destroy]
   before_action :set_approvement, only: [:destroy]

  # POST /approvements or /approvements.json
  def create
    @new_approvement = @task.approvements.build(approvement_params)
    @new_approvement.user = current_user

    if @new_approvement.save
      redirect_to tasks_url, notice: "Approvement was successfully made"
    else
      render 'tasks/show', alert: "Error occured"
    end
  end

  # DELETE /approvements/1 or /approvements/1.json
  def destroy
    message = {notice: "Approvement was deleted"}

    if current_user_can_edit?(@approvement)
      @approvement.destroy
    else
      message = {alert: "Error occured"}
    end

    redirect_to tasks_url, message
  end

  private

    def set_task
      @task = Task.find(params[:task_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_approvement
      @approvement = @task.approvements.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def approvement_params
      params.fetch(:approvement, {})
    end
end
