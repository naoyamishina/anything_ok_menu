require 'rails_helper'

RSpec.describe Comment, type: :model do

  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context '本文が存在しない場合' do
    it '無効であること' do
      comment = build(:comment, body: nil)
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include('を入力してください')
    end
  end

  context '本文が65535文字以内の場合' do
    it '有効であること' do
      comment = build(:comment, body: 'a' * 65535)
      expect(comment).to be_valid
    end
  end

  context '本文が65536文字以上の場合' do
    it '無効であること' do
      comment = build(:comment, body: 'a' * 65536)
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include('は65535文字以内で入力してください')
    end
  end
end