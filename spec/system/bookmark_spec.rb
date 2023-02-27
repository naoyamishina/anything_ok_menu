require 'rails_helper'

RSpec.describe 'ブックマーク', type: :system do
  let!(:user) { create(:user) }
  let(:menu) { create(:menu, user: user) }
  let!(:menu_by_others) { create(:menu) }

  describe 'ブックマークの登録、削除' do
    context 'ログインしていない場合' do
      it 'メニュー一覧でブックマークボタンが表示されないこと' do
        visit menus_path
        expect(page).not_to have_selector("#bookmark-button-for-menu-#{menu.id}")
      end
    end

    context 'ログインしている場合' do
      before {login_as(user)}

      it 'ブックマーク登録できる' do
        sleep 0.5
        visit menus_path
        click_link "bookmark-button-for-menu-#{menu_by_others.id}"
        expect(page).to have_selector("#unbookmark-button-for-menu-#{menu_by_others.id}")
        visit user_bookmarks_path(user_id: user.id)
        expect(page).to have_content(menu_by_others.name), 'ブックマーク一覧画面にメニューのタイトルが表示されていません'
      end

      it 'ブックマーク登録を解除できる' do
        sleep 0.5
        visit menus_path
        click_link "bookmark-button-for-menu-#{menu_by_others.id}"
        expect(page).to have_selector("#unbookmark-button-for-menu-#{menu_by_others.id}")
        click_link "unbookmark-button-for-menu-#{menu_by_others.id}"
        sleep 0.5
        visit user_bookmarks_path(user_id: user.id)
        expect(page).not_to have_content(menu_by_others.name), 'ブックマークを解除したメニューのタイトルが表示されます'
      end
    end
  end
end