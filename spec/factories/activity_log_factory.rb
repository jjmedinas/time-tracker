FactoryBot.define do
  factory :activity_log do
    association :user, factory: :user
    active { true }
    checked_in_at { nil }
    checked_out_at { nil }
  end
end
