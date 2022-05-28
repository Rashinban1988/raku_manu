class Manual < ApplicationRecord

  has_many :learnings, dependent: :destroy
  has_many :employees, through: :learnings
  has_many :comments, dependent: :destroy
  has_many :employees, through: :comments
  belongs_to :genre

  has_one_attached :video

  with_options presence: true do
    validates :task_name, presence: true
    validates :description, presence: true
    validates :video
    validates :genre_id
  end
  validate :video_size

  def video_size
    if video.blob.byte_size > 60.megabytes
      errors.add(:video, "動画を撮影しなおして下さい←60MB約3分以内")
    end
  end

end
