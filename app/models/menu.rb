class Menu < ApplicationRecord
  enum eat_at: { anytime: 0, breakfast: 1, lunch: 2, dinner: 3, snack: 4 }
  mount_uploader :menu_image, MenuImageUploader

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :menu_tags, dependent: :destroy
  has_many :tags, through: :menu_tags
  has_many :eats, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :memo, length: { maximum: 65_535 }

  def save_tag(sent_tags)
    # 新しいタグ名は新規create、存在するタグ名は既存から検索し、new_menu_tagに代入
    # new_menu_tagを関連menuのタグに入れる
    sent_tags.each do |tag|
      new_menu_tag = Tag.find_or_create_by(name: tag)
      tags << new_menu_tag
    end
  end

  def create_notification_bookmark!(current_user)
    # すでに「bookmark」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and menu_id = ? and action = ? ", current_user.id, user_id, id, 'bookmark'])
    # ブックマークされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        menu_id: id,
        visited_id: user_id,
        action: 'bookmark'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_eat!(current_user)
    # 食べる通知は複数可能なように、通知レコードを作成
    notification = current_user.active_notifications.new(
      menu_id: id,
      visited_id: user_id,
      action: 'eat'
    )
    # 自分の投稿に対する食べるの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user)
    # コメント通知は複数可能なように、通知レコードを作成
    notification = current_user.active_notifications.new(
      menu_id: id,
      visited_id: user_id,
      action: 'comment'
    )
    # 自分の投稿に対する食べるの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
