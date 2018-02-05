class User < ApplicationRecord

  has_many :subscriptions
  has_many :resorts, :through => :subscriptions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :default_values

  def default_values
    self.account = 'individual'
  end

  # def super_admin?
  #   email == "isabellecorp@gmail.com"
  # end
end
