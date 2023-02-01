class ChangeBookmarksToLikes < ActiveRecord::Migration[7.0]
  def change
    rename_table :bookmarks, :likes
  end
end
