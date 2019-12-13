FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    email { "john@doe.com" }
    gender { "male" }
    role { "employee" }
  end
end