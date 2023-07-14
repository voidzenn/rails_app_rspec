module Api
  module V1
    module RescueException
      extend ActiveSupport::Concern

      included do
        rescue_from ActionController::ParameterMissing do |err|
          render_invalid_params_response
        end

        protected
        def render_invalid_params_response
          render json: {error_message: "Parameter Misisng"}, status: :bad_request
        end
      end
    end
  end
end