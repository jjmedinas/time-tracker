require 'rails_helper'

RSpec.describe UserReport, type: :model do
  describe "#columns" do
    it "returns an array with column names" do
      user = create(:user_with_activity_logs)

      report = UserReport.new(user)

      expect(report.columns).to match_array ["ID", "Day", "Check in at", "Check out at", "Worked hours"]
    end
  end

  describe "#data" do
    it "returns user activity data" do
      user = create(:user_with_activity_logs)

      report = UserReport.new(user)

      expected_result = user.activity_logs.map{|a|
        [
          a.id, a.checked_in_at.strftime("%b %e, %Y"),
          a.checked_in_at.strftime("%H:%M"),
          a.checked_out_at.strftime("%H:%M"),
          a.worked_hours
        ]
      }

      expect(report.data).to match_array expected_result

    end
  end
end
