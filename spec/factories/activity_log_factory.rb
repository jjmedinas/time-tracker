FactoryBot.define do
  factory :activity_log do
    association :user, factory: :user
    active { true }
    checkin { DateTime.now }
    checkout { nil }
  end
end
