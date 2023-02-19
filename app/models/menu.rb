class Menu < ApplicationRecord
  enum eat_at: { anytime: 0, breakfast: 1, lunch: 2, dinner: 3 }
  mount_uploader :menu_image, MenuImageUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :menu_tags, dependent: :destroy
  has_many :tags, through: :menu_tags
  has_many :eats, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :memo, length: { maximum: 65_535 }

  def save_tag(sent_tags)
    # 新しいタグ名は新規create、存在するタグ名は既存から検索し、new_post_tagに代入
    # new_post_tagを関連postのタグに入れる
    sent_tags.each do |tag|
      new_menu_tag = Tag.find_or_create_by(name: tag)
      tags << new_menu_tag
    end
  end
end
