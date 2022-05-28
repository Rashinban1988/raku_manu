class Comment < ApplicationRecord

  belongs_to :employee
  belongs_to :manual
  has_many :return_comments, dependent: :destroy

  validates :comment, presence: true

end
