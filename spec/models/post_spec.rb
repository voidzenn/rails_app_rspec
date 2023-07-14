require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    let(:short_characters) {"aa"}
    let(:long_characters) {Faker::Lorem.sentences(number: 21)}

    describe "#title attribute" do
      it {is_expected.to validate_presence_of(:title)}

      context "when value is below minimum" do
        it {is_expected.not_to allow_value(short_characters).for(:title)}
      end

      context "when value is beyond maximum" do
        it {is_expected.not_to allow_value(long_characters).for(:title)}
      end
    end

    describe "#content attribute" do
      it {is_expected.to validate_presence_of(:content)}

      context "when value is below minimum" do
        it {is_expected.not_to allow_value(short_characters).for(:title)}
      end

      context "when value is beyond maximum" do
        it {is_expected.not_to allow_value(long_characters).for(:title)}
      end
    end
  end
end
