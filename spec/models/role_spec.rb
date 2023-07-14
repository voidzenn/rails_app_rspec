require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "Role validations" do
    describe "#name" do
      it {is_expected.to validate_presence_of(:name)}
      it {is_expected.to validate_length_of(:name).is_at_least(4).is_at_most(30)}
    end
  end

  describe "Role associations" do
    it {is_expected.to have_one(:user).class_name("User")}
  end
end
