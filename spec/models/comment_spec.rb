require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "コメント作成のバリデーションテスト" do

    it 'すべてのカラムにデータがあれば有効であること' do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it 'コメント本文がなければ無効であること' do
      comment = build(:comment, body: nil)
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include('を入力してください')
    end

    it 'コメント本文が65535文字以下であれば有効であること' do
      comment = build(:comment, body: 'a' * 65535)
      expect(comment).to be_valid
    end

    it 'コメント本文が65536文字以上であれば有効であること' do
      comment = build(:comment, body: 'a' * 65536)
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include('は65535文字以内で入力してください')
    end
  end
end