FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    email { "john@doe.com" }
    gender { "male" }
    role { "employee" }
  end

  factory :user_2, class: User do
    first_name { "Foo" }
    last_name  { "Bar" }
    email { "foo@bar.com" }
    gender { "male" }
    role { "employee" }
  end

  factory :user_3, class: User do
    first_name { "Gin" }
    last_name  { "Ale" }
    email { "gin@ale.com" }
    gender { "female" }
    role { "employee" }
  end
end