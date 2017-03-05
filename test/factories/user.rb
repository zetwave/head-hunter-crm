FactoryGirl.define do
  factory :user do
    name                    "Gargantua"
    email                   {Faker::Internet.email}
    password_digest         {User.digest('password')}
    admin                   false
    activated               true
    activated_at            {Date.today}
  end
end