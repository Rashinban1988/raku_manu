class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :learnings, dependent: :destroy
  has_many :manuals, through: :learnings
  has_many :comments, dependent: :destroy
  has_many :manuals, through: :comments

  def self.guest
    Employee.find_or_create_by(email: "guest@example.com") do |employee|
      employee.password = SecureRandom.urlsafe_base64
        # employee.confirmed_ad = Time.now
    end
  end

end
