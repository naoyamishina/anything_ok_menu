require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe "メニュー作成のバリデーションテスト" do

    it 'すべてのカラムにデータがあれば有効であること' do
      menu = build(:menu)
      expect(menu).to be_valid
    end

    it 'メニュー名がなければ無効であること' do
      menu = build(:menu, name: nil)
      expect(menu).to be_invalid
      expect(menu.errors[:name]).to include('を入力してください')
    end

    it 'メニュー名が255文字以下であれば有効であること' do
      menu = build(:menu, name: 'a' * 255)
      expect(menu).to be_valid
    end

    it 'メニュー名が256文字以上であれば無効であること' do
      menu = build(:menu, name: 'a' * 256)
      expect(menu).to be_invalid
      expect(menu.errors[:name]).to include('は255文字以内で入力してください')
    end

    it 'メニューメモが65535文字以下であれば有効であること' do
      menu = build(:menu, memo: 'a' * 65535)
      expect(menu).to be_valid
    end

    it 'メニューメモが65536文字以上であれば無効であること' do
      menu = build(:menu, memo: 'a' * 65536)
      expect(menu).to be_invalid
      expect(menu.errors[:memo]).to include('は65535文字以内で入力してください')
    end
  end
end
