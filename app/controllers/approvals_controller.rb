class ApprovalsController < ApplicationController
  def create
    return redirect_to tasks_url, alert: "You can't approve own task" if task.user == current_user

    @new_approval = task.approvals.build(approval_params)
    @new_approval.user = current_user

    if @new_approval.save
      redirect_to tasks_url, notice: "Approval was successfully made"
    else
      render 'tasks/show', alert: "Error occured"
    end
  end

  def destroy
    message = { notice: "Approval was deleted" }

    if current_user_can_edit_approval?(approval)
      approval.destroy
    else
      message = {alert: "Error occured"}
    end

    redirect_to tasks_url, message
  end

  private

    def task
      @task = Task.find(params[:task_id])
    end

    def approval
      @approval = task.approvals.find(params[:id])
    end

    def approval_params
      params.fetch(:approval, {})
    end
end
