class Menu < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :memo, length: { maximum: 65_535 }
end
