require 'rails_helper'

RSpec.describe Menu, type: :model do

  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      menu = build(:menu)
      expect(menu).to be_valid
    end
  end

  context 'タイトルが存在しない場合' do
    it '無効であること' do
      menu = build(:menu, name: nil)
      expect(menu).to be_invalid
      expect(menu.errors[:name]).to include('を入力してください')
    end
  end

  context 'タイトルが255文字以下の場合' do
    it '有効であること' do
      menu = build(:menu, name: 'a' * 255)
      expect(menu).to be_valid
    end
  end

  context 'タイトルが256文字以上の場合' do
    it '無効であること' do
      menu = build(:menu, name: 'a' * 256)
      expect(menu).to be_invalid
      expect(menu.errors[:name]).to include('は255文字以内で入力してください')
    end
  end

  context '本文が65535文字以内の場合' do
    it '有効であること' do
      menu = build(:menu, memo: 'a' * 65535)
      expect(menu).to be_valid
    end
  end

  context '本文が65536文字以上の場合' do
    it '無効であること' do
      menu = build(:menu, memo: 'a' * 65536)
      expect(menu).to be_invalid
      expect(menu.errors[:memo]).to include('は65535文字以内で入力してください')
    end
  end
end
