require 'rails_helper'

RSpec.describe ActivityLog, type: :model do
  describe "Validations" do
    it { should belong_to(:user) }
  end

  context "#check_in" do
    it "updates checked_in_at" do
      activity_log = create(:empty_activity_log)
      expect(activity_log.checked_in_at).to be_nil

      activity_log.check_in!
      expect(activity_log.checked_in_at).not_to be_nil
      expect(activity_log.checked_in_at).to be_instance_of(ActiveSupport::TimeWithZone)
    end

    it "raises an error if check in can't be done" do
      activity_log = create(:empty_activity_log, checked_in_at: 1.day.ago)

      expect { activity_log.check_in! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "#check_out" do
    it "updates checked_out_at" do
      activity_log = create(:empty_activity_log, checked_in_at: DateTime.now)
      expect(activity_log.checked_out_at).to be_nil

      activity_log.check_out!
      expect(activity_log.checked_out_at).not_to be_nil
      expect(activity_log.checked_out_at).to be_instance_of(ActiveSupport::TimeWithZone)
    end

    it "raises an error if check out can't be done" do
      # When activity log hasn't been checked in
      activity_log = create(:empty_activity_log)
      expect { activity_log.check_out! }.to raise_error(ActiveRecord::RecordInvalid)

      # When activity log is already checked out
      activity_log.update(checked_in_at: 1.day.ago, checked_out_at: DateTime.now)
      expect { activity_log.check_out! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
