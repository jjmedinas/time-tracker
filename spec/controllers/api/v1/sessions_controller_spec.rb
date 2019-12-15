require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "GET #create" do
    it "returns a success response" do
      user = create(:user)
      expect(session[:user_id]).to eq nil

      post :create, params: { session: { email: user.email, password: user.password }}

      expect(response).to be_successful
      expect(session[:user_id]).to eq user.id
    end

    it "returns http 401 if email and password dont match" do
      user = create(:user)
      expect(session[:user_id]).to eq nil

      post :create, params: { session: { email: user.email, password: "bad-password" }}

      should respond_with(401)
      expect(session[:user_id]).to eq nil
    end
  end

  describe "GET #destroy" do
    it "logs out the user" do
      user = create(:user)
      expect(session[:user_id]).to eq nil

      post :create, params: { session: { email: user.email, password: user.password }}

      expect(response).to be_successful
      expect(session[:user_id]).to eq user.id

      delete :destroy

      expect(response).to be_successful
      expect(session[:user_id]).to eq nil
    end
  end
end
