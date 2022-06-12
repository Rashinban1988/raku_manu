class Manual < ApplicationRecord

  has_many :learnings, dependent: :destroy
  has_many :employees, through: :learnings
  has_many :comments, dependent: :destroy
  has_many :employees, through: :comments
  belongs_to :genre

  has_one_attached :video

  validates :task_name, presence: true
  validates :video, presence: true

  validate :video_size, :video_type

  def video_size
    if video.blob.byte_size > 60.megabytes
      errors.add(:video, "動画を60MG以内で撮影しなおして下さい（約３分以内）")
    end
  end

  def video_type
    if !"video".in?(video.blob.content_type)
      errors.add(:video, "はmp4またはwebm形式でアップロードしてください")
    end
  end

  def learned?(employee)
    learnings.where(employee_id: employee.id).exists?
  end

end
