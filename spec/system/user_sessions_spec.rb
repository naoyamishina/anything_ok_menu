require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード (英数字3文字以上)', with: 'password'
        click_button 'ログイン'
        # expect(page).to have_content 'Login successful'
        expect(page).to have_current_path menus_path
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード (英数字3文字以上)', with: 'password'
        click_button 'ログイン'
        # expect(page).to have_content 'Login failed'
        expect(page).to have_current_path login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login_as(user)
        find('#header-profile').click
        click_link 'ログアウト'
        # expect(page).to have_content 'Logged out'
        expect(page).to have_current_path root_path
      end
    end
  end
end
