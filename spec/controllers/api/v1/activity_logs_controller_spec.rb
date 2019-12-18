require 'rails_helper'

RSpec.describe Api::V1::ActivityLogsController, type: :controller do
  describe "GET #current" do
    it "returns a success response" do
      activity_log = create(:empty_activity_log)

      get :current, params: { user_id: activity_log.user.id } ,
                    session: { user_id: activity_log.user.id }

      expect(response).to be_successful
    end
  end

  describe "POST #check_in" do
    context "When activity_log can be checked in" do
      it "returns a success response" do
        activity_log = create(:empty_activity_log)

        get :check_in, params: { user_id: activity_log.user.id },
                       session: { user_id: activity_log.user.id }

        expect(response).to be_successful
      end
    end

    context "When activity_log can NOT be checked in" do
      it "returns a success response" do
        activity_log = create(:empty_activity_log, checked_in_at: 1.day.ago)

        get :check_in, params: { user_id: activity_log.user.id },
                       session: { user_id: activity_log.user.id }

        should respond_with(400)
      end
    end
  end

  describe "POST #check_out" do
    context "When activity_log can be checked out" do
      it "returns a success response" do
        activity_log = create(:empty_activity_log, checked_in_at: 1.day.ago)

        get :check_out, params: { user_id: activity_log.user.id },
                        session: { user_id: activity_log.user.id }

        expect(response).to be_successful
      end
    end

    context "When activity_log can NOT be checked out" do
      it "returns a success response" do
        activity_log = create(:empty_activity_log)

        get :check_out, params: { user_id: activity_log.user.id },
                        session: { user_id: activity_log.user.id }

        should respond_with(400)
      end
    end
  end

  describe "GET #report" do
    context "When user is admin" do
      it "returns data to print report" do
        user = create(:admin)

        create_list(:user_with_activity_logs, 2)

        get :report, params: { start_date: 2.days.ago, end_date: 1.day.from_now },
                               session: { user_id: user.id }

        expect(response).to be_successful
      end

      it "returns http 400 if params are not sent" do
        user = create(:admin)

        create_list(:user_with_activity_logs, 2)

        get :report, session: { user_id: user.id }

        should respond_with(400)
      end
    end
    context "When user is NOT admin" do
      it "returns http code 403" do
        user = create(:user)
        create_list(:user_with_activity_logs, 2)

        get :report, session: { user_id: user.id }

        should respond_with(403)
      end
    end
  end
end
