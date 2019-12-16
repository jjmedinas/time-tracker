require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "GET #login" do
    it "returns a success response" do

      get :login

      expect(response).to be_successful
    end
  end
end
