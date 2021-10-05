class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy
  has_many :approvals, dependent: :destroy

  validates :name, presence: true, length: {maximum: 35}
  validates :email, uniqueness: true

  before_validation :set_name, on: :create

  private

  def set_name
    self.name = "User №#{rand(2000)}" if self.name.blank?
  end
end
