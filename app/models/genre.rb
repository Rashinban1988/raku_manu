class Genre < ApplicationRecord

  has_many :manuals, dependent: :destroy

  validates :name, presence: true

end
