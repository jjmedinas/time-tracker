require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should have_many(:activity_logs) }
    it "validates" do
      expect(User.new(email: 'foo@bar.com')).to validate_presence_of(:email)
      expect(User.new(email: 'foo@bar.com')).to validate_uniqueness_of(:email)
      expect(User.new(email: 'foobar.com').invalid?).to eq true
    end
  end

  describe "factory bot test" do
    it "test it" do
      user = build(:user)
      expect(user.first_name).to eq "John"
    end
  end
end
