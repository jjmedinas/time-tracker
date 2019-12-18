FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    gender { "male" }
    password { "123456" }
    role { "employee" }
    sequence(:email) { |n| "user-#{n}@email.com" }

    factory :user_with_activity_logs do
      transient do
        activity_logs_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:activity_log, evaluator.activity_logs_count, user: user)
      end
    end
  end

  factory :user_2, class: User do
    first_name { "Foo" }
    last_name  { "Bar" }
    email { "foo@bar.com" }
    gender { "male" }
    password { "123456" }
    role { "employee" }
  end

  factory :user_3, class: User do
    first_name { "Gin" }
    last_name  { "Ale" }
    email { "gin@ale.com" }
    gender { "female" }
    password { "123456" }
    role { "employee" }
  end
end
