class Menu < ApplicationRecord
  mount_uploader :menu_image, MenuImageUploader

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :memo, length: { maximum: 65_535 }
end
