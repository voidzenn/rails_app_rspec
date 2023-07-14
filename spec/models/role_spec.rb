require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "relationships" do
    it {is_expected.to have_one(:user).class_name("User")}
  end

  describe "validaitons" do
    describe "#name attribute" do
      it do
        is_expected.to validate_presence_of(:name)
        is_expected.to validate_length_of(:name).is_at_least(4).is_at_most(30)
      end
    end
  end
end
