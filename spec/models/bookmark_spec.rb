require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let!(:user) { create(:user) }
  let!(:menu) { create(:menu) }

  describe "ブックマークのバリデーションテスト" do
    context 'ユーザーidとメニューidの組み合わせが一意である時' do
      it 'いずれも一意であると有効である' do
        bookmark = build(:bookmark)
        expect(bookmark).to be_valid
        expect(bookmark.errors).to be_empty
      end

      it 'user_idのみ一意であると有効である' do
        bookmark = create(:bookmark, user_id: user.id)
        other_bookmark = build(:bookmark, user_id: user.id)
        expect(other_bookmark).to be_valid
        expect(other_bookmark.errors).to be_empty
      end

      it 'menu_idのみ一意であると有効である' do
        bookmark = create(:bookmark, menu_id: menu.id)
        other_bookmark = build(:bookmark, menu_id: menu.id)
        expect(other_bookmark).to be_valid
        expect(other_bookmark.errors).to be_empty
      end
    end

    context 'ユーザーidとメニューidの組み合わせが一意でない時' do
      it '無効である' do
        bookmark = create(:bookmark, user_id: user.id, menu_id: menu.id)
        other_bookmark = build(:bookmark, user_id: user.id, menu_id: menu.id)
        expect(other_bookmark).to be_invalid
      end
    end
  end
end
