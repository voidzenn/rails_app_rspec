require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it {is_expected.to belong_to(:role).class_name("Role").with_foreign_key(:role_id)}
  end

  describe "validations" do
    describe "#fname attribute" do
      it do
        is_expected.to validate_presence_of(:fname)
        is_expected.to validate_length_of(:fname).is_at_least(3).is_at_most(50)
      end
    end

    describe "#lname attribute" do
      it do
        is_expected.to validate_presence_of(:lname)
        is_expected.to validate_length_of(:lname).is_at_least(3).is_at_most(50)
      end
    end

    describe "#age attribute" do
      context "when age less than 18 and is a string" do
        it {is_expected.to_not allow_value(9).for(:age)}
        it {is_expected.to_not allow_value("a").for(:age)}
      end

      context "when age greater than or equal to 18" do
        it {is_expected.to allow_value(18).for(:age)}
        it {is_expected.to allow_value(25).for(:age)}
      end
    end

    describe "#location attribute" do
      it {is_expected.to validate_length_of(:location).is_at_least(3)}
    end

    describe "#password attribute" do
      it {is_expected.to validate_length_of(:password).is_at_least(8)}
    end

    describe "#email attribute" do
      context "when format is valid" do
        it {is_expected.to allow_value("user@user.com").for(:email)}
      end

      context "when format not valid" do
        it {is_expected.to_not allow_value("user@user").for(:email)}
        it {is_expected.to_not allow_value("user.com").for(:email)}
        it {is_expected.to_not allow_value("user@user@.com").for(:email)}
      end
    end
  end
end
