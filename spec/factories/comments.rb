FactoryBot.define do
  factory :comment do
    text { '綺麗な景色ですね' }
    unknown { 5 }
    association :spot
    association :user
  end
end
