class Eat < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  has_many :notifications, dependent: :destroy
end
