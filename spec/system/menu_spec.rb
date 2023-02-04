require 'rails_helper'

RSpec.describe 'Menus', type: :system do
  let!(:user) { create(:user) }
  let(:menu) { create(:menu, user: user) }
  let(:menu_by_others) { create(:menu) }

  describe 'メニューのCRUD' do
    describe 'メニュー一覧表示' do
      context 'ログインしていない場合' do
        it 'ボタンからメニュー一覧へ遷移できること' do
          visit menus_path
          click_on('みんなのメニュー')
          expect(current_path).to eq(menus_path), 'ヘッダーのリンクからメニュー一覧画面へ遷移できません'
        end
      end

      context 'ログインしている場合' do
        before {login_as(user)}

        it 'ボタンからメニュー一覧へ遷移できること' do
          click_on('みんなのメニュー')
          expect(current_path).to eq(menus_path), 'ヘッダーのリンクからメニュー一覧画面へ遷移できません'
        end

        context 'メニューが一件もない場合' do
          before {login_as(user)}
          it '何もない旨のメッセージが表示されること' do
            visit menus_path
            expect(page).to have_content('メニューがありません'), 'メニューが一件もない場合、「メニューがありません」というメッセージが表示されていません'
          end
        end

        context 'メニューがある場合' do
          before {login_as(user)}
          it 'メニューの一覧が表示されること' do
            menu
            visit menus_path
            expect(page).to have_content(menu.name), 'メニュー一覧画面にメニューのタイトルが表示されていません'
            expect(page).to have_content(menu.user.name), 'メニュー一覧画面に投稿者のフルネームが表示されていません'
          end

          it '自分のメニュー一覧が表示されること' do
            menu
            visit mymenus_menus_path
            expect(page).to have_content(menu.name), '自分メニュー一覧画面にメニューのタイトルが表示されていません'
            expect(page).to have_content(menu.user.name), '自分のメニュー一覧画面に投稿者の名前が表示されていません'
          end
        end
      end
    end

    describe 'メニュー新規登録' do
      context 'フォームの入力値が正常' do
        before {login_as(user)}
        it 'メニューの新規作成が成功する' do
          sleep 0.5
          visit new_menu_path
          fill_in 'メニュー名', with: 'test_title'
          fill_in 'メモ', with: 'test_content'
          click_button '登録する'
          expect(page).to have_content 'test_title'
          expect(page).to have_current_path menus_path
        end
      end

      context 'メニュー名が未入力' do
        before {login_as(user)}
        it 'タスクの新規作成が失敗する' do
          sleep 0.5
          visit new_menu_path
          fill_in 'メニュー名', with: ''
          fill_in 'メモ', with: 'test_content'
          click_button '登録する'
          expect(page).to have_content 'メニューを作成できませんでした'
          expect(page).to have_content "メニュー名を入力してください"
          expect(page).to have_current_path new_menu_path
        end
      end
    end

    describe '掲示板の編集' do
      context '他人の掲示板の場合' do
        it '編集ボタン・削除ボタンが表示されないこと' do
          login_as(user)
          sleep 0.5
          visit menu_path menu_by_others
          expect(page).not_to have_selector("#button-edit-#{menu_by_others.id}")
          expect(page).not_to have_selector("#button-delete-#{menu_by_others.id}")
        end
      end
      context '自分の掲示板の場合' do
        it '編集ボタン・削除ボタンが表示されること' do
          login_as(user)
          sleep 0.5
          visit menu_path menu
          expect(page).to have_selector("#button-edit-#{menu.id}")
          expect(page).to have_selector("#button-delete-#{menu.id}")
        end
      end
    end
  end
end