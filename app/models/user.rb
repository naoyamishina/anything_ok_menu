class User < ApplicationRecord
  authenticates_with_sorcery!

  enum gender: { other: 0, man: 1, woman: 2 }
  enum role: { general: 0, admin: 1 }
  mount_uploader :avatar, AvatarUploader
  has_many :menus, dependent: :destroy 
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_menus, through: :bookmarks, source: :menu
  has_many :eats, dependent: :destroy
  has_many :eat_menus, through: :eats, source: :menu
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def own?(object)
    id == object.user_id
  end

  def bookmark(menu)
    bookmark_menus << menu
  end

  def unbookmark(menu)
    bookmark_menus.destroy(menu)
  end

  def bookmark?(menu)
    menu.bookmarks.pluck(:user_id).include?(id)
  end

  def eat(menu)
    eat_menus << menu
  end

end
