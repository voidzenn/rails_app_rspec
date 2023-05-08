require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:role) { FactoryBot.create(:role) }
  let(:user) { FactoryBot.create(:user) }
  let(:valid_params) do
    {
      fname: "new user",
      lname: "user",
      role_id: role.id
    }
  end

  describe "POST #create" do
    context "When user create failed" do
      context "When :fname field too short" do
        let(:invalid_params) do
          !valid_params[:fname] = "ab"
          valid_params
        end

        before do
          post :create, params: { user: invalid_params }
        end

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end

      context "When :lname field too short" do
        let(:invalid_params) do
          !valid_params[:lname] = "ab"
          valid_params
        end

        before do
          post :create, params: { user: invalid_params }
        end

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end

      context "When :role_id field empty" do
        let(:invalid_params) do
          !valid_params[:role_id] = ""
          valid_params
        end

        before do
          post :create, params: { user: invalid_params }
        end

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end

      context "When missing :fname field" do
        let(:invalid_params) { valid_params.except(:fname) }

        before do
          post :create, params: { user: invalid_params }
        end

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end

      context "When missing :lname field" do
        let(:invalid_params) { valid_params.except(:lname) }

        before do
          post :create, params: { user: invalid_params }
        end

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end

      context "When missing :role_id field" do
        let(:invalid_params) { valid_params.except(:role_id) }

        before do
          post :create, params: { user: invalid_params }
        end

        it "return 400" do
          expect(response).to have_http_status(400)
        end
      end
    end

    context "When user create successfully" do
      before { post :create, params: { user: valid_params } }

      it "return success with valid params" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #index" do
    context "When users retrieved successfully" do
      before do
        allow(User).to receive(:all).and_return([{}])
        get :index
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #show" do
    context "When user not found" do
      before do
        allow(User).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, params: { id: 0 }
      end

      it "return 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "When user retrieved successfully" do
      before do
        get :index, params: { id: user.id }
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "PUT #update" do
    context "When user not found" do
      before do
        allow(User).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, params: { id: 0 }
      end

      it "return 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "When user update failed" do
      context "When user validations failed" do
        context "When :fname too short" do
          let(:invalid_params) do
            !valid_params[:fname] = "ab"
            valid_params
          end

          before do
            put :update, params: { id: user.id, user: invalid_params }
          end

          it "return 400" do
            expect(response).to have_http_status(400)
          end
        end

        context "When :lname field too short" do
          let(:invalid_params) do
            !valid_params[:lname] = "ab"
            valid_params
          end

          before do
            post :create, params: { user: invalid_params }
          end

          it "return 400" do
            expect(response).to have_http_status(400)
          end
        end

        context "When :role_id field empty" do
          let(:invalid_params) do
            !valid_params[:role_id] = ""
            valid_params
          end

          before do
            post :create, params: { user: invalid_params }
          end

          it "return 400" do
            expect(response).to have_http_status(400)
          end
        end
      end
    end

    context "When user updated successfully" do
      let(:new_params) do
        !valid_params[:fname] = "new data"
        valid_params
      end

      before do
        put :update, params: { id: user.id, user: new_params }
      end

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    context "When user not found" do
      before do
        allow(User).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        delete :destroy, params: { id: user.id }
      end

      it "return 404" do
        expect(response).to have_http_status(404)
      end
    end

    context "When user deleted successfully" do
      before { delete :destroy, params: { id: user.id } }

      it "return 200" do
        expect(response).to have_http_status(200)
      end
    end
  end
end