class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :learnings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :return_comments, dependent: :destroy

  validates :name, presence: true
  validates :telephone_number, presence: true

  def self.guest
    Employee.find_or_create_by(email: "guest@example.com") do |employee|
      employee.password = SecureRandom.urlsafe_base64
        # employee.confirmed_ad = Time.now
    end
  end

end
