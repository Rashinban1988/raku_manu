class Genre < ApplicationRecord

  has_many :manuals, dependent: :destroy
  has_many :comments, through: :manuals
  has_many :learnings, through: :manuals

  validates :name, presence: true

end
