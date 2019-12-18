FactoryBot.define do
  factory :empty_activity_log, class: ActivityLog do
    association :user, factory: :user
    active { true }
    checked_in_at { }
    checked_out_at { }
  end

  factory :activity_log do

    association :user, factory: :user
    active { true }
    checked_in_at { 1.day.ago.beginning_of_day + 10.hours }
    checked_out_at { checked_in_at + 8.hours }
  end
end
