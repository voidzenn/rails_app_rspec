require 'rails_helper'

RSpec.describe Api::V1::RolesController, type: :controller  do
  let(:role) {FactoryBot.create(:role)}
  let(:valid_params) {{ name: "Member"}}

  describe "POST #create" do
    context "when failed in creating role" do
      context "when the name is too short" do
        let(:invalid_params) {{name: "abc"}}

        before {post :create, params: {role: invalid_params}}

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end
    end

    context "when role saved successfully" do
      before {post :create, params: {role: valid_params}}

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #index" do
    context "when roles data retrieved successfully" do
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
    context "when roles data retrieved failed" do
      before do
        allow(Role).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, params: {id: role.id}
      end

      it "return 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "when roles data retrieved successfully" do
      before {get :show, params: {id: role.id}}

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "PUT #update" do
    context "when roles data update failed" do
      context "When role not found" do
          before do
          allow(Role).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
          put :update, params: {id: role.id, role: valid_params}
        end

        it "return 404" do
          expect(response).to have_http_status(404)
        end
      end

      context "when user validations fail" do
        context "When :name is less than 3" do
          let(:invalid_params) do
            !valid_params[:name] = "a"
            valid_params
          end

          before {put :update, params: {id: role.id, role: invalid_params}}

          it "return 400" do
            expect(response).to have_http_status(400)
          end
        end

        context "when :name is greater than 40" do
          let(:invalid_params) do
            !valid_params[:name] = Faker::Lorem.characters(number: 42)
            valid_params
          end

          before {put :update, params: {id: role.id, role: invalid_params}}

          it "return 400" do
            expect(response).to have_http_status(400)
          end
        end
      end
    end

    context "when roles data updated successfully" do
      before {put :update, params: {id: role.id, role: valid_params}}

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:valid_params) do
      {
        fname: "new user",
        lname: "user",
        role_id: role.id
      }
    end
    let(:user) {User.create(valid_params)}

    context "when roles delete failed" do
      context "when role_id foreign_key constraint error mysql" do
        before do
          allow(Role).to receive(:find).and_return(role)
          allow(role).to receive(:destroy!).and_raise(ActiveRecord::InvalidForeignKey)
          delete :destroy, params: {id: user.role_id}
        end

        it "return 422" do
          expect(response).to have_http_status(422)
        end
      end
    end

    context "when roles delete successfully" do
      context "when role has no foreign_key constraint" do
        before do
          User.delete user.id
          delete :destroy, params: {id: user.role_id}
        end

        it "return 200" do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
