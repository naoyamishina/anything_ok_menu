# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_22_230030) do
  create_table "bookmarks", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_bookmarks_on_menu_id"
    t.index ["user_id", "menu_id"], name: "index_bookmarks_on_user_id_and_menu_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "comments", charset: "utf8mb4", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_comments_on_menu_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "eats", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_eats_on_menu_id"
    t.index ["user_id"], name: "index_eats_on_user_id"
  end

  create_table "menu_tags", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "menu_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id", "tag_id"], name: "index_menu_tags_on_menu_id_and_tag_id", unique: true
    t.index ["menu_id"], name: "index_menu_tags_on_menu_id"
    t.index ["tag_id"], name: "index_menu_tags_on_tag_id"
  end

  create_table "menus", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.text "memo"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "menu_image"
    t.integer "eat_at", default: 0, null: false
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "notifications", charset: "utf8mb4", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "menu_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["menu_id"], name: "index_notifications_on_menu_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "tags", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.integer "gender", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "bookmarks", "menus"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "comments", "menus"
  add_foreign_key "comments", "users"
  add_foreign_key "eats", "menus"
  add_foreign_key "eats", "users"
  add_foreign_key "menu_tags", "menus"
  add_foreign_key "menu_tags", "tags"
  add_foreign_key "menus", "users"
end
