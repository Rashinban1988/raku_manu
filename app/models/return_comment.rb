class ReturnComment < ApplicationRecord

  belongs_to :comment
  belongs_to :employee

  validates :return_comment, presence: true

end
