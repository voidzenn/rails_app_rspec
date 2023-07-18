require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:short_characters) {"ab"}

  describe "GET #index" do
    context "when users retrieved successfully" do
      context "when users data empty" do
        before do
          allow(User).to receive(:all).and_return([{}])
          get :index
        end

        it "return 200" do
          expect(response).to have_http_status(200)
        end
      end

      context "when users data not emtpy" do
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
    context "when user not found" do
      before do
        allow(User).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, params: {id: 0}
      end

      it "return 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "when user retrieved successfully" do
      let(:new_user) {create :user}

      before {get :index, params: {id: new_user.id}}

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST #create" do
    context "when user create successfully" do
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
    context "when user not found" do
      before do
        allow(User).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        put :update, params: {id: 0}
      end

      it "return 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "when user updated successfully" do
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
    context "when user not found" do
      before do
        allow(User).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        delete :destroy, params: {id: 0}
      end

      it "return 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "when user deleted successfully" do
      let(:user) {create :user}

      before {delete :destroy, params: {id: user.id}}

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
