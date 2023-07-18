require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe "GET #index" do
    context "when posts data retrieved successfully" do
      before {get :index, params: {}}

      it {expect(response).to have_http_status(200)}
    end
  end

  describe "GET #show" do
    context "when post not found" do
      let(:role) {create :role}

      before do
        allow(Post).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, params: {id: role.id}
      end

      it do
        expect(response).to have_http_status(404)
      end
    end

    context "when posts retrieved successfully" do
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
    context "when post failed to save" do
      context "when params empty" do
        before {post :create, params: {}}

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end
    end

    context "when post successfully saved" do
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
    context "when post update failed" do
      context "when post not found" do
        let(:role) {create :role}

        before do
          allow(Post).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
          put :update, params: {id: role.id}
        end

        it do
          expect(response).to have_http_status(404)
        end
      end
    end

    context "when post update successfully" do
      context "when post parmas is satisfied" do
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
    context "when post delete failed" do
      context "when post not found" do
        let(:role) {create :role}

        before do
          allow(Post).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
          delete :destroy, params: {id: role.id}
        end

        it do
          expect(response).to have_http_status(404)
        end
      end
    end

    context "when post delete successfully" do
      let(:new_post) {create :post}

      before {delete :destroy, params: {id: new_post.id}}

      it {expect(response).to have_http_status(200)}
    end
  end
end
