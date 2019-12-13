require 'rails_helper'

RSpec.describe ActivityLog, type: :model do
  describe "Validations" do
    it { should belong_to(:user) }
  end
end
