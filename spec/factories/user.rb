FactoryBot.define do
  factory :user do
    name                  { '山田太郎' }
    email                 { 'a123@com.jp' }
    password              { 'a12345' }
    password_confirmation { password }
    profile               { '東南アジアが好きです。よろしくお願いします。' }
  end
end
