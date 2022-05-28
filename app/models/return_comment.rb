class ReturnComment < ApplicationRecord

  belongs_to :comment

  validates :return_comment, presence: true

end
