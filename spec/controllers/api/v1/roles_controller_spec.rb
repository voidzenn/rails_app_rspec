require 'rails_helper'

RSpec.describe Api::V1::RolesController, type: :controller  do
  describe "GET #index" do
    context "when role data retrieved successfully" do
      before do
        FactoryBot.create(:role)
        get :index
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #show" do
    context "when role data retrieved failed" do
      context "when role not found" do
        let(:role) {create :role}

        before do
          allow(Role).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
          get :show, params: {id: role.id}
        end

        it "return 404" do
          expect(response).to have_http_status(404)
        end
      end
    end

    context "when roles data retrieved successfully" do
      let(:role) {create :role}

      before {get :show, params: {id: role.id}}

      it do
        expect(response).to have_http_status(200)
        expect(response_body[:data][:name]).to eq role[:name]
      end
    end
  end

  describe "POST #create" do
    context "when failed in creating role" do
      context "when params is empty" do
        before {post :create, params: {}}

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end
    end

    context "when role saved successfully" do
      let(:role) {build_stubbed :role}
      let(:params) do
        {
          name: role.name
        }
      end

      before {post :create, params: {role: params}}

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "PUT #update" do
    context "when role data update failed" do
      context "when role not found" do
        before do
          allow(Role).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
          put :update, params: {id: 0}
        end

        it {expect(response).to have_http_status(404)}
      end
    end

    context "when roles data updated successfully" do
      let(:new_role) {create :role}
      let(:role) {build_stubbed :role}
      let(:params) do
        {
          name: role.name
        }
      end

      before {put :update, params: {id: new_role.id, role: params}}

      it do
        expect(response).to have_http_status(200)
        expect(response_body[:data][:name]).to eq params[:name]
      end
    end
  end

  describe "DELETE #destroy" do
    context "when role delete failed" do
      context "when role not found" do
        let(:role) {create :role}

        before do
          allow(Role).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
          delete :destroy, params: {id: role.id}
        end

        it {expect(response).to have_http_status(404)}
      end

      context "when role_id foreign_key constraint error mysql" do
        context "when role is used by a user" do
          let(:role) {create :role}
          let(:user) {build_stubbed(:user)}
          let(:new_user) do
            FactoryBot.create(
              :user,
              fname: user.fname,
              lname: user.lname,
              role_id: role.id
            )
          end

          before do
            delete :destroy, params: {id: new_user.role_id}
          end

          it "return 500" do
            expect(response).to have_http_status(500)
          end
        end
      end
    end

    context "when role delete successfully" do
      let(:role) {create :role}

      before do
        delete :destroy, params: {id: role.id}
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
