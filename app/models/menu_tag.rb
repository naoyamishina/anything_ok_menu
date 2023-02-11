class MenuTag < ApplicationRecord
  belongs_to :menu
  belongs_to :tag
  validates :menu_id, presence: true
  validates :tag_id, presence: true
end