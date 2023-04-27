require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User validations" do
    describe "validates presence" do
      it { should validate_presence_of(:fname) }
      it { should validate_presence_of(:lname) }
    end

    describe "validates length" do
      it { should validate_length_of(:fname).is_at_least(3).is_at_most(50) }
      it { should validate_length_of(:lname).is_at_least(3).is_at_most(50) }

      describe "#age" do
        context "when age less than 18 and is a string" do
          it { should_not allow_value(9).for(:age) }
          it { should_not allow_value("a").for(:age) }
        end

        context "when age greater than or equal to 18" do
          it { should allow_value(18).for(:age) }
          it { should allow_value(25).for(:age) }
        end
      end

      it { should validate_length_of(:location).is_at_least(3) }
      it { should validate_length_of(:password).is_at_least(8) }
    end

    describe "validates format" do
      describe "#email" do
        context "when format is valid" do
          it { should allow_value("user@user.com").for(:email) }
        end

        context "when format not valid" do
          it { should_not allow_value("user@user").for(:email) }
          it { should_not allow_value("user.com").for(:email) }
          it { should_not allow_value("user@user@.com").for(:email) }
        end
      end
    end
  end
end
