FactoryBot.define do
  factory :bookmark do
    association :user
    association :menu
  end
end
