require 'rails_helper'

RSpec.describe 'コメント', type: :system do
  let!(:me) { create(:user) }
  let(:menu) { create(:menu) }
  let(:comment_by_me) { create(:comment, user: me, menu: menu) }
  let(:comment_by_others) { create(:comment, menu: menu) }

  describe 'コメントのCRUD' do
    before do
      comment_by_me
      comment_by_others
    end
    describe 'コメントの一覧' do
      before {login_as(me)}
      it 'コメントの一覧が表示されること' do
        sleep 0.5
        visit menu_path menu
        within('#js-table-comment') do
          expect(page).to have_content(comment_by_me.body)
          expect(page).to have_content(comment_by_me.user.name)
        end
      end
    end

    describe 'コメントの作成' do
      before {login_as(me)}
      it 'コメントを作成できること', js: true do
        sleep 0.5
        visit menu_path menu
        fill_in 'js-new-comment-body', with: '新規コメント'
        click_on 'js-comment-create-btn'
        wait_for_ajax do
          comment = Comment.last
          within("#comment-#{comment.id}") do
            expect(page).to have_content(me.name)
            expect(page).to have_content '新規コメント'
          end
        end
        
      end

      it 'コメントの作成に失敗すること', js: true do
        sleep 0.5
        visit menu_path menu
        fill_in 'js-new-comment-body', with: ''
        click_on '投稿'
      end
    end

    describe 'コメントの編集' do
      context '他人のコメントの場合' do
        before {login_as(me)}
        it '削除ボタンが表示されないこと' do
          sleep 0.5
          visit menu_path menu
          within("#comment-#{comment_by_others.id}") do
            expect(page).not_to have_selector('.js-delete-comment-button')
          end
        end
      end
    end
  end
end