FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "タグ#{n}" }
  end
end