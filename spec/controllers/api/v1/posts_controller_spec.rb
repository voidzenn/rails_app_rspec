require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  shared_context "post not found" do
    before do
      allow(Post).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
      get :show, params: {id: 0}
    end

    it {expect(response).to have_http_status(:not_found)}
  end

  describe "GET #index" do
    context "When posts data retrieved successfully" do
      before {get :index, params: {}}

      it {expect(response).to have_http_status(200)}
    end
  end

  describe "GET #show" do
    it_behaves_like "post not found"

    context "When posts retrieved successfully" do
      let(:new_post) {create :post}

      before {get :show, params: {id: new_post.id}}

      it do
        expect(response).to have_http_status(200)
        expect(response_body[:data][:title]).to eq new_post[:title]
        expect(response_body[:data][:content]).to eq new_post[:content]
      end
    end
  end

  describe "POST #create" do
    context "When post failed to save" do
      context "When params empty" do
        before {post :create, params: {}}

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end
    end

    context "When post successfully saved" do
      let(:user) {create :user}
      let(:params) do
        {
          title: Faker::Lorem.characters(number: 20),
          content: Faker::Lorem.characters(number: 20),
          user_id: user.id,
        }
      end

      before {post :create, params:  {post: params}}

      it do
        expect(response).to have_http_status(200)
        expect(response_body[:data][:title]).to eq params[:title]
        expect(response_body[:data][:content]).to eq params[:content]
        expect(response_body[:data][:user_id]).to eq params[:user_id]
      end
    end
  end

  describe "PUT #update" do
    context "When post update failed" do
      it_behaves_like "post not found"
    end

    context "When post update successfully" do
      context "When post parmas is satisfied" do
        let(:new_post) {create :post}
        let(:params) do
          {
            title: Faker::Lorem.characters(number: 20),
            content: Faker::Lorem.characters(number: 20),
          }
        end

        before {put :update, params: {id: new_post.id, post: params}}

        it {expect(response).to have_http_status(200)}
      end
    end
  end

  describe "DELETE #destroy" do
    context "When post delete failed" do
      it_behaves_like "post not found"
    end

    context "When post delete successfully" do
      let(:new_post) {create :post}

      before {delete :destroy, params: {id: new_post.id}}

      it {expect(response).to have_http_status(200)}
    end
  end
end
