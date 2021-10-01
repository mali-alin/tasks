class Task < ApplicationRecord
  belongs_to :user
  has_many :approvements
  has_many :users_who_approved, through: :approvements, source: :user

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
  end

  private

  def complete_rules?
    self.approvements.size >= 2
  end
end
