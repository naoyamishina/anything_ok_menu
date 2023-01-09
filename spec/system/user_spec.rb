require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit new_user_path
          fill_in 'ユーザーネーム', with: 'test'
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          # expect(page).to have_content 'User was successfully created.'
          expect(current_path).to eq login_path
        end
      end

      context '名前が未入力' do
        it 'ユーザーの新規作成に失敗する' do
          visit new_user_path
          fill_in 'ユーザーネーム', with: ''
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          # expect(page).to have_content '1 error prohibited this user from being saved'
          # expect(page).to have_content "Email can't be blank"
          expect(current_path).to eq users_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in 'ユーザーネーム', with: 'test'
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          # expect(page).to have_content '1 error prohibited this user from being saved'
          # expect(page).to have_content "Email can't be blank"
          expect(current_path).to eq users_path
        end
      end

      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in 'ユーザーネーム', with: 'test'
          fill_in 'メールアドレス', with: existed_user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          # expect(page).to have_content '1 error prohibited this user from being saved'
          # expect(page).to have_content 'Email has already been taken'
          expect(current_path).to eq users_path
          expect(page).to have_field 'メールアドレス', with: existed_user.email
        end
      end
    end
  end
end