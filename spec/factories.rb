FactoryBot.define do
  factory :user do
    name  { "Jeremy Flores" }
    email { "contato@flores.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end

  factory :post do
    content { "Oh mama! I wanna go Surfing!" }
    user
  end
end