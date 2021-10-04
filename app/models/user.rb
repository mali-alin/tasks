class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy
  has_many :approvals, dependent: :destroy

  validates :username, presence: true, length: {maximum: 35}
  validates :email, uniqueness: true

  before_validation :set_name, on: :create

  private

  def set_name
    self.username = "Пользователь №#{rand(2000)}" if self.username.blank?
  end
end
