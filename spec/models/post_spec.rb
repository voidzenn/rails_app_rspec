require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Validations" do
    describe "validates presence" do
      describe "#title" do
        it {is_expected.to validate_presence_of(:title)}
      end

      describe "#content" do
        it {is_expected.to validate_presence_of(:content)}
      end
    end

    describe "validates length" do
      let(:short_characters) { "aa" }
      let(:long_characters) { "aaaaaaaaaaaaaaaaaaaaa" }

      describe "#title" do
        context "when value is below minimum" do
          it {is_expected.not_to allow_value(short_characters).for(:title)}
        end

        context "when value is beyond maximum" do
          it {is_expected.not_to allow_value(long_characters).for(:title)}
        end
      end

      describe "#content" do
        context "when value is below minimum" do
          it {is_expected.not_to allow_value(short_characters).for(:title)}
        end

        context "when value is beyond maximum" do
          it {is_expected.not_to allow_value(long_characters).for(:title)}
        end
      end
    end
  end
end
