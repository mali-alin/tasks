class Task < ApplicationRecord
  belongs_to :user
  has_many :approvals
  has_many :users_who_approved, through: :approvals, source: :user

  validates :name, presence: true
  validates :user, presence: true

  state_machine :status, initial: :new do
    state :new
    state :in_progress
    state :completed
    state :canceled

    event :start do
      transition new: :in_progress
    end

    event :complete do
      transition in_progress: :completed, if: :complete_rules?
    end

    event :cancel do
      transition in_progress: :canceled
    end

    event :cancel_approval do
      transition completed: :in_progress
    end

    after_transition to: :canceled do |task|
      task.update(canceled_at: Time.current)
    end

    after_transition to: :completed do |task|
      task.update(time_finished: Time.current)
    end
  end

  private

  def complete_rules?
    self.approvals.size >= 2
  end
end
