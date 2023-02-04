class Menu < ApplicationRecord
  enum eat_at: { anytime: 0, breakfast: 1, lunch: 2, dinner: 3 }
  mount_uploader :menu_image, MenuImageUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :memo, length: { maximum: 65_535 }
end
