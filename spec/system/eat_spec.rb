require 'rails_helper'

RSpec.describe '食べる', type: :system do
  let!(:user) { create(:user) }
  let(:menu) { create(:menu, user: user) }
  let!(:menu_by_others) { create(:menu) }

  describe '食べるの登録、削除' do
    context 'ログインしていない場合' do
      it 'メニュー一覧で食べるボタンが表示されないこと' do
        visit menus_path
        expect(page).not_to have_selector("eat_botton")
      end
    end

    context 'ログインしている場合' do
      before {login_as(user)}

      it '食べる登録できる' do
        sleep 0.5
        visit menus_path
        click_link("eat_botton")
        expect(page.accept_confirm).to eq "食べる予定にしますか？"
        visit eats_path
        expect(page).to have_content(menu_by_others.name), '食べる一覧画面にメニューのタイトルが表示されていません'
      end

      it '食べる登録を解除できる' do
        sleep 0.5
        visit menus_path
        click_link("eat_botton")
        expect(page.accept_confirm).to eq "食べる予定にしますか？"
        visit eats_path
        click_link("js-delete-eat-button")
        expect(page.accept_confirm).to eq "削除しますか？"
        expect(page).not_to have_content(menu_by_others.name), '食べるを解除したメニューのタイトルが表示されます'
      end
    end
  end
end