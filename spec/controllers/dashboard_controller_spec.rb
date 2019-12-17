require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "GET #login" do
    it "returns a success response" do
      get :login

      expect(response).to be_successful
    end
  end

  describe "GET #index" do
    it "returns a success response if user logged in" do
      user = create(:user)

      get :index, session: { user_id: user.id }
      expect(response).to be_successful
    end

    it "responds with http 403 forbidden" do
      get :index

      should respond_with(403)
    end
  end
end
