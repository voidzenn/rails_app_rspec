require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe "GET #index" do
    context "When posts data retrieved successfully" do
      before { get :index, params: {} }

      it { expect(response).to have_http_status(200) }
    end
  end
end
