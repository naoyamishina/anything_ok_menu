class Like < ApplicationRecord
  belongs_to :user
  belongs_to :menu

  validates :user_id, uniqueness: { scope: :menu_id }
end
