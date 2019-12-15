require 'rails_helper'

RSpec.describe Api::V1::ActivityLogsController, type: :controller do
  describe "GET #current" do
    it "returns a success response" do
      activity_log = create(:activity_log)

      get :current, params: { user_id: activity_log.user.id } ,
                    session: { user_id: activity_log.user.id }

      expect(response).to be_successful
    end
  end

  describe "POST #check_in" do
    context "When activity_log can be checked in" do
      it "returns a success response" do
        activity_log = create(:activity_log)

        get :check_in, params: { user_id: activity_log.user.id },
                       session: { user_id: activity_log.user.id }

        expect(response).to be_successful
      end
    end

    context "When activity_log can NOT be checked in" do
      it "returns a success response" do
        activity_log = create(:activity_log, checked_in_at: 1.day.ago)

        get :check_in, params: { user_id: activity_log.user.id },
                       session: { user_id: activity_log.user.id }

        should respond_with(400)
      end
    end
  end

  describe "POST #check_out" do
    context "When activity_log can be checked out" do
      it "returns a success response" do
        activity_log = create(:activity_log, checked_in_at: 1.day.ago)

        get :check_out, params: { user_id: activity_log.user.id },
                        session: { user_id: activity_log.user.id }

        expect(response).to be_successful
      end
    end

    context "When activity_log can NOT be checked out" do
      it "returns a success response" do
        activity_log = create(:activity_log)

        get :check_out, params: { user_id: activity_log.user.id },
                        session: { user_id: activity_log.user.id }

        should respond_with(400)
      end
    end
  end
end
