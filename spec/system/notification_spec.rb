require 'rails_helper'

RSpec.describe '通知', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:menu) { create(:menu, user: user) }

  describe '通知がくる' do
    context 'ログインしていない場合' do
      it 'ヘッダーに通知一覧リンクが表示されないこと' do
        visit menus_path
        expect(page).not_to have_selector("#notification-botton")
      end
    end

    context 'ログインしている場合' do
      it 'ヘッダーに通知一覧リンクが表示されること' do
        login_as(user)
        sleep 0.5
        visit menus_path
        expect(page).to have_selector("#notification-botton")
      end
    end

    context '通知が一件もない場合' do
      it '何もない旨のメッセージが表示されること' do
        login_as(user)
        sleep 0.5
        click_link("notification-botton")
        expect(page).to have_content('通知はありません。')
      end
    end

    context '食べるボタンが押された場合' do
      it '他人が自分のメニューに食べるを押した時通知がくること' do
        eat_click(other_user)
        login_as(user)
        sleep 0.5
        click_link("notification-botton")
        expect(page).to have_content(other_user.name)
        expect(page).to have_content(menu.name)
        expect(page).to have_selector("#eat_notification")
      end

      it '自分のメニューに食べるを押した時通知がこないこと' do
        login_as(user)
        sleep 0.5
        click_link("eat_botton")
        expect(page.accept_confirm).to eq "食べる予定にしますか？"
        sleep 0.1
        click_link("notification-botton")
        expect(page).not_to have_content(user.name)
        expect(page).not_to have_content(menu.name)
        expect(page).not_to have_selector("#eat_notification")
      end
    end

    context 'ブックマークされた場合' do
      it '他人が自分のメニューをブックマークした時通知がくること' do
        bookmark_click(other_user)
        login_as(user)
        sleep 0.5
        click_link("notification-botton")
        expect(page).to have_content(other_user.name)
        expect(page).to have_content(menu.name)
        expect(page).to have_selector("#bookmark_notification")
      end

      it '自分のメニューをブックマークした時通知がこないこと' do
        login_as(user)
        sleep 0.5
        click_link "bookmark-button-for-menu-#{menu.id}"
        sleep 0.1
        click_link("notification-botton")
        expect(page).not_to have_content(user.name)
        expect(page).not_to have_content(menu.name)
        expect(page).not_to have_selector("#bookmark_notification")
      end
    end

    context 'コメントされた場合' do
      it '他人が自分のメニューにコメントをした時通知がくること' do
        comment_by(other_user)
        login_as(user)
        sleep 0.5
        click_link("notification-botton")
        expect(page).to have_content(other_user.name)
        expect(page).to have_content(menu.name)
        expect(page).to have_selector("#comment_notification")
      end

      it '自分のメニューにコメントをした時通知がこないこと' do
        login_as(user)
        sleep 0.5
        visit menu_path menu
        fill_in 'js-new-comment-body', with: '新規コメント'
        click_on 'js-comment-create-btn'
        sleep 0.1
        click_link("notification-botton")
        expect(page).not_to have_content(user.name)
        expect(page).not_to have_content(menu.name)
        expect(page).not_to have_selector("#comment_notification")
      end
    end
  end
end