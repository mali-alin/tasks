class Approvement < ApplicationRecord
  belongs_to :task
  belongs_to :user

  validates :task, presence: true

  validates :user, uniqueness: { scope: :task_id }
end
