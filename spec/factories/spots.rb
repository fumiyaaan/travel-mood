FactoryBot.define do
  factory :spot do
    title { 'ビクトリア城' }
    description { '1000年の歴史があるスポットです。' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/victoriano-izquierdo-HoevDVvxInw-unsplash.jpg'), filename: 'victoriano-izquierdo-HoevDVvxInw-unsplash.jpg')
    end
  end
end
