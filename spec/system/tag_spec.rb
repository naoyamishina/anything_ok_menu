require 'rails_helper'

RSpec.describe 'タグ', type: :system do
  let!(:user) { create(:user) }
  let!(:menu) { create(:menu, user: user) }

  describe '新規作成' do
    before {login_as(user)}

    it 'タグが保存されること' do
      sleep 0.5
      visit new_menu_path
      fill_in 'メニュー名', with: 'test_title'
      fill_in 'メモ', with: 'test_content'
      fill_in 'タグ', with: 'test_tag'
      click_button '登録する'
      expect(page).to have_content 'test_tag'
      expect(page).to have_current_path menus_path
    end

    it 'タグが複数保存されること' do
      sleep 0.5
      visit new_menu_path
      fill_in 'メニュー名', with: 'test_title'
      fill_in 'メモ', with: 'test_content'
      fill_in 'タグ', with: 'tag1,tag2,tag3'
      click_button '登録する'
      expect(page).to have_content('tag1')
      expect(page).to have_content('tag2')
      expect(page).to have_content('tag3')
      expect(page).to have_current_path menus_path
    end

    it '同じタグを入力しても重複してレコードが生成されないこと' do
      sleep 0.5
      visit new_menu_path
      fill_in 'メニュー名', with: 'test_title'
      fill_in 'メモ', with: 'test_content'
      fill_in 'タグ', with: 'tag1,tag2,tag3'
      click_button '登録する'

      visit new_menu_path
      fill_in 'メニュー名', with: 'test_title'
      fill_in 'メモ', with: 'test_content'
      fill_in 'タグ', with: 'tag1,tag2,tag3'
      expect { click_button '登録する' }.not_to change { Tag.count }
    end
  end

  describe '編集' do
    before {login_as(user)}

    it 'タグの編集ができること' do
      sleep 0.5
      visit edit_menu_path(menu)
      fill_in 'メニュー名', with: 'test_title'
      fill_in 'メモ', with: 'test_content'
      fill_in 'タグ', with: 'tag'
      click_button '更新する'
      expect(page).to have_content('tag')

      visit edit_menu_path(menu)
      fill_in 'タグ', with: 'change-tag'
      click_button '更新する'
      expect(page).to have_content('change-tag')
    end

  end
end