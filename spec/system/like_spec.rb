require 'rails_helper'

RSpec.describe 'お気に入り', type: :system do
  let!(:user) { create(:user) }
  let(:menu) { create(:menu, user: user) }
  let!(:menu_by_others) { create(:menu) }

  describe 'お気に入りの登録、削除' do
    context 'ログインしていない場合' do
      it 'メニュー一覧でお気に入りボタンが表示されないこと' do
        visit menus_path
        expect(page).not_to have_selector("#like-button-for-menu-#{menu.id}")
      end

      it 'お気に入り一覧に遷移できないこと' do
        visit likes_menus_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path
      end
    end

    context 'ログインしている場合' do
      before {login_as(user)}

      it 'お気に入り登録できる' do
        sleep 0.5
        visit menus_path
        click_link "like-button-for-menu-#{menu_by_others.id}"
        expect(page).to have_selector("#unlike-button-for-menu-#{menu_by_others.id}")
        visit likes_menus_path
        expect(page).to have_content(menu_by_others.name), 'お気に入り一覧画面にメニューのタイトルが表示されていません'
      end

      it 'お気に入り登録を解除できる' do
        sleep 0.5
        visit menus_path
        click_link "like-button-for-menu-#{menu_by_others.id}"
        expect(page).to have_selector("#unlike-button-for-menu-#{menu_by_others.id}")
        click_link "unlike-button-for-menu-#{menu_by_others.id}"
        sleep 0.5
        visit likes_menus_path
        expect(page).not_to have_content(menu_by_others.name), 'お気に入りを解除したメニューのタイトルが表示されます'
      end

      it '自分の投稿はお気に入り登録できない' do
        sleep 0.5
        visit menus_path
        expect(page).not_to have_selector("#like-button-for-menu-#{menu.id}"), '自分のメニューをお気に入りできます'
      end
    end
  end
end