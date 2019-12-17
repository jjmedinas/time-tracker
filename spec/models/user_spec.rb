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

  describe "#downcase_email" do
    it "downcases the email before creating the record" do
      user = create(:user, email: "FoO@Bar.COm")
      expect(user.email).to eq "foo@bar.com"
    end
  end

  describe "#full_name" do
    it "capitalizes first and last names and merge them" do
      user = create(:user, first_name: "juan jose", last_name: "medina sarmiento")
      expect(user.full_name).to eq "Juan Jose Medina Sarmiento"
    end
  end
end
