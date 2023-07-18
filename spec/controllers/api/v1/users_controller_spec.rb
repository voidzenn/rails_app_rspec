require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:short_characters) {"ab"}

  shared_context "user not found" do
    context "When user not found" do
      before do
        allow(User).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, params: {id: 0}
      end

      it "return 404" do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET #index" do
    context "When users retrieved successfully" do
      context "When users data empty" do
        before do
          allow(User).to receive(:all).and_return([{}])
          get :index
        end

        it "return 200" do
          expect(response).to have_http_status(200)
        end
      end

      context "When users data not emtpy" do
        before do
          FactoryBot.create(:user)
          get :index
        end

        it "return 200" do
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  describe "GET #show" do
    it_behaves_like "user not found"

    context "When user retrieved successfully" do
      let(:new_user) {create :user}

      before {get :index, params: {id: new_user.id}}

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST #create" do
    it_behaves_like "user not found"

    context "When user create successfully" do
      let(:user) {build_stubbed :user}
      let(:params) do
        {
          fname: user.fname,
          lname: user.lname,
          role_id: user.role_id,
        }
      end

      before {post :create, params: {user: params}}

      it do
        expect(response).to have_http_status(200)
        expect(response_body[:data][:fname]).to eq params[:fname]
        expect(response_body[:data][:lname]).to eq params[:lname]
        expect(response_body[:data][:role_id]).to eq params[:role_id]
      end
    end
  end

  describe "PUT #update" do
    it_behaves_like "user not found"

    context "When user updated successfully" do
      let(:user) {create :user}
      let(:new_user) {build_stubbed :user}
      let(:params) do
        {
          fname: new_user.fname,
          lname: new_user.lname,
          role_id: new_user.role_id,
        }
      end

      before {put :update, params: {id: user.id, user: params}}

      it do
        expect(response).to have_http_status(200)
        expect(response_body[:data][:fname]).to eq params[:fname]
        expect(response_body[:data][:lname]).to eq params[:lname]
        expect(response_body[:data][:role_id]).to eq params[:role_id]
      end
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "user not found"

    context "When user deleted successfully" do
      let(:user) {create :user}

      before {delete :destroy, params: {id: user.id}}

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
