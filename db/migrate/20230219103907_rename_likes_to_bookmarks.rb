class RenameLikesToBookmarks < ActiveRecord::Migration[7.0]
  def change
    rename_table :likes, :bookmarks
  end
end
