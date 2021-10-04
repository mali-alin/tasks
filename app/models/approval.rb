class Approval < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :task, presence: true
  validates :user, uniqueness: { scope: :task_id }

  after_create :approve_task

  after_destroy :cancel_task

  private

  def approve_task
    if Approval.where(task_id: self.task.id).size >= 2
      self.task.complete!
    end
  end

  def cancel_task
    if Approval.where(task_id: self.task.id).size < 2
      self.task.cancel_approval!
    end
  end
end
