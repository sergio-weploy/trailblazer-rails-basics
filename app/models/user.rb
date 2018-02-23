class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  belongs_to :organisation#, optional: true

  after_initialize :set_default_role, :if => :new_record?

  # Validations
  validates :name, presence: true, length: { minimum: 3 }
  validates :email, uniqueness: true, format: { with: Devise::email_regexp }
  validates :password, presence: true

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
