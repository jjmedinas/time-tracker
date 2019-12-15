FactoryBot.define do
  factory :admin, class: User do
    first_name { "Admin" }
    last_name  { "Tracker" }
    gender { "male" }
    password { "123456" }
    role { "admin" }

    sequence(:email) { |n| "admin#{n}@email.com" }
  end
end
