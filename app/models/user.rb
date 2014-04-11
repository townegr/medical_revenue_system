class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dollar_per_rvu, numericality: { only_integer: true }
  validates :job_title, presence: true, inclusion: [
    'Medical Provider',
    'Administrative Staff'
  ]

  def full_name
    "#{first_name} #{last_name}"
  end
end
