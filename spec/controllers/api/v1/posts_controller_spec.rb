require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe "GET #index" do
    context "When posts data retrieved successfully" do
      before { get :index, params: {} }

      it { expect(response).to have_http_status(200) }
    end
  end

  describe "POST #create" do
    let(:user) {create :user}
    let(:post_parmas) do
      {
        title: Faker::Lorem.characters(number: 20),
        content: Faker::Lorem.characters(number: 20),
        user_id: user.id,
      }
    end

    context "When post successfully saved" do
      before {post :create, params: { post: post_parmas }}

      it { expect(response).to have_http_status(200) }
    end
  end
end
