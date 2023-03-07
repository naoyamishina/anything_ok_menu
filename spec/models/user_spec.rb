require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    it 'すべてのカラムにデータがあれば有効であること' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "nameがなければ無効であること" do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to eq ["を入力してください"]
    end

    it "emailがなければ無効であること" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to eq ["を入力してください"]
    end

    it "重複したemailなら無効であること" do
      user = create(:user)
      other_user = build(:user, email: user.email)
      expect(other_user).to be_invalid
      expect(other_user.errors[:email]).to eq ["はすでに存在します"]
    end

    it "3文字以下のパスワードなら無効であること" do
      user = build(:user, password: "a", password_confirmation: "a")
      expect(user).to be_invalid
      expect(user.errors[:password]).to eq ["は3文字以上で入力してください"]
    end

    it "パスワードの確認が一致しなければ無効であること" do
      user = build(:user, password: "password", password_confirmation: "test")
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません"]
    end
  end
end
