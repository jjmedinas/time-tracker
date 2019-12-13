require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "validates" do
      expect(User.new(email: 'foo@bar.com')).to validate_presence_of(:email)
      expect(User.new(email: 'foo@bar.com')).to validate_uniqueness_of(:email)
    end
  end

  describe "factory bot test" do
    it "test it" do
      user = build(:user)
      expect(user.first_name).to eq "John"
    end
  end
end
