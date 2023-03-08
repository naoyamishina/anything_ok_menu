require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "タグ作成のバリデーションテスト" do
    it 'すべてのカラムにデータがあれば有効であること' do
      tag = build(:tag)
      expect(tag).to be_valid
      expect(tag.errors).to be_empty
    end

    it "重複したタグ名なら無効であること" do
      tag = create(:tag)
      other_tag = build(:tag, name: tag.name)
      expect(other_tag).to be_invalid
      expect(other_tag.errors[:name]).to eq ["はすでに存在します"]
    end

    it 'タグ名がなければ無効であること' do
      tag = build(:tag, name: nil)
      expect(tag).to be_invalid
      expect(tag.errors[:name]).to eq ["を入力してください"]
    end

    it 'タグ名が255文字以下であれば有効であること' do
      tag = build(:tag, name: 'a'*255)
      expect(tag).to be_valid
      expect(tag.errors).to be_empty
    end

    it 'タグ名が256文字以上であれば無効であること' do
      tag = build(:tag, name: 'a'*256)
      expect(tag).to be_invalid
      expect(tag.errors[:name]).to eq ["は255文字以内で入力してください"]
    end
  end
end
