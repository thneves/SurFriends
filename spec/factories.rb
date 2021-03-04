FactoryBot.define do
  factory :user do
    name { 'Jeremy Flores' }
    email { 'contato@flores.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end

  # factory :user2 do
  #   name { "Griffin Colapinto" }
  #   email { "contato@cola@.com" }
  #   password { "foobar" }
  #   password_confirmation { "foobar" }
  # end

  factory :post do
    content { 'Oh mama! I wanna go Surfing!' }
    user
  end
end
