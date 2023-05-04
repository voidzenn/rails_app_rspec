require 'rails_helper'

RSpec.describe Api::V1::RolesController, type: :controller  do
  let(:role) { Role.create(name: 'Admin') }
  let(:valid_params) { { name: "Member" } }
  let(:invalid_params) { { name: "abc"} }

  describe "POST #create" do
    context "When failed in creating role" do
      context "When the name is too short" do
        before { post :create, params: { role: invalid_params } }

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end
    end

    context "When role saved successfully" do
      before do
        post :create, params: { role: valid_params }
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #index" do
    context "When roles data retrieved failed" do
      before do
        allow(Role).to receive(:all).and_return([])
        get :index
      end

      it "return 400" do
        expect(response).to have_http_status(400)
      end
    end

    context "When roles data retrieved successfully" do
      before do
        allow(Role).to receive(:all).and_return([{}])
        get :index
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #show" do
    context "When roles data retrieved failed" do
      before do
        allow(Role).to receive(:find).and_return([])
        get :index, params: { id: 1 }
      end

      it "return 400" do
        expect(response).to have_http_status(400)
      end
    end

    context "When roles data retrieved successfully" do
      before do
        get :index, params: { id: role.id }
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "PUT #update" do
    context "When roles data updated failed" do
      before do
        allow(Role).to receive(:find).and_return(false)
        get :update, params: { id: role.id, role: invalid_params }
      end

      it "return 400" do
        expect(response).to have_http_status(400)
      end
    end

    context "When roles data updated successfully" do
      before do
        get :update, params: { id: role.id, role: valid_params }
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    context "When roles data deleted failed" do
      before do
        allow(Role).to receive(:find).and_return(false)
        delete :destroy, params: { id: role.id }
      end

      it "return 400" do
        expect(response).to have_http_status(400)
      end
    end

    context "When roles data deleted successfully" do
      before do
        delete :destroy, params: { id: role.id }
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
