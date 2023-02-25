class CreateMenuTags < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_tags do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :menu_tags, [:menu_id, :tag_id], unique: true
  end
end
