require 'rails_helper'

RSpec.describe AllUsersReport, type: :model do
  describe "#columns" do
    it "returns an array with column names" do
      users = create_list(:user, 3)
      start_date = 1.week.ago
      end_date = 1.day.ago

      report = AllUsersReport.new(users, start_date: start_date, end_date: end_date)

      expect(report.columns).to match_array ["User", "Email", "Worked hours"]
    end
  end

  describe "#data" do
    it "returns an array with data" do
      # Create 2 users with 3 activity_logs each.
      # Each activity log shows they worked 8 hours
      # Period of time of the activity log, between yesterday and current date
      users = create_list(:user_with_activity_logs, 2)

      start_date = Date.today - 2.days
      end_date = start_date + 3.days

      report = AllUsersReport.new(users, start_date: start_date, end_date: end_date)


      expect(report.data).to match_array [[ users.first.full_name, users.first.email, 24 ],
                                          [ users.last.full_name, users.last.email, 24 ]]

      activity_log = users.first.activity_logs.first
      activity_log.update(checked_in_at: 1.year.ago, checked_out_at: 1.year.ago + 5.hours)

    end

    it "Sums up th worked hours and returns an array with data" do
      # Create 2 users with 3 activity_logs each.
      # Each activity log shows they worked 8 hours
      # Period of time of the activity log, between yesterday and current date
      users = create_list(:user_with_activity_logs, 2)

      start_date = Date.today - 2.days
      end_date = start_date + 3.days

      # Updating activity log to add 5 worked hours
      activity_log = users.first.activity_logs.first
      activity_log.update(checked_in_at: 1.day.ago.beginning_of_day + 10.hours,
                         checked_out_at: 1.day.ago.beginning_of_day + 15.hours)

      report = AllUsersReport.new(users, start_date: start_date, end_date: end_date)

      expect(report.data).to match_array [[ users.first.full_name, users.first.email, 21 ],
                                          [ users.last.full_name, users.last.email, 24 ]]

    end

    it "excludes records outside date range and returns an array with data" do
      # Create 2 users with 3 activity_logs each.
      # Each activity log shows they worked 8 hours
      # Period of time of the activity log, between yesterday and current date
      users = create_list(:user_with_activity_logs, 2)

      start_date = Date.today - 2.days
      end_date = start_date + 3.days
      activity_log = users.last.activity_logs.first
      activity_log.update(checked_in_at: 1.year.ago, checked_out_at: 1.year.ago + 5.hours)

      report = AllUsersReport.new(users, start_date: start_date, end_date: end_date)

      expect(report.data).to match_array [[ users.first.full_name, users.first.email, 24 ],
                                          [ users.last.full_name, users.last.email, 16 ]]

    end
  end
end
