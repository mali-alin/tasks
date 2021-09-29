class Task < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :user, presence: true

  state_machine initial: :new do
    state :new
    state :in_progress
    state :completed
    state :canceled

    event :start do
      transition new:  :in_progress
    end

    event :completed do
      transition in_progress: :completed
    end

    event :canceled do
      transition in_progress: :canceled
    end
  end
end
