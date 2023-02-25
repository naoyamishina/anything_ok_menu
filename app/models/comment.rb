class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { maximum: 65_535 }
end
