class User < ApplicationRecord
  authenticates_with_sorcery!

  enum gender: { other: 0, man: 1, woman: 2 }
  enum role: { general: 0, admin: 1 }
  mount_uploader :avatar, AvatarUploader
  has_many :menus, dependent: :destroy 
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_menus, through: :likes, source: :menu

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def own?(object)
    id == object.user_id
  end

  def like(menu)
    like_menus << menu
  end

  def unlike(menu)
    like_menus.destroy(menu)
  end

  def like?(menu)
    menu.likes.pluck(:user_id).include?(id)
  end
end
