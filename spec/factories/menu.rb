FactoryBot.define do
  factory :menu do
    sequence(:name) { |n| "メニュー#{n}" }
    sequence(:memo) { |n| "メモ#{n}" }
    association :user
  end
end