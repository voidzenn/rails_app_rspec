module Api
  module V1
    module RescueException
      extend ActiveSupport::Concern

      included do
        rescue_from ActionController::ParameterMissing, JSON::ParserError, ArgumentError  do |err|
          render_invalid_params_response err
        end
        rescue_from ActionController::BadRequest, ActiveRecord::RecordInvalid, with: :render_bad_request
        rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
        rescue_from ActiveRecord::InvalidForeignKey, with: :render_invalid_foreignkey

        protected
        def render_invalid_params_response error
          render json: {error: error}, status: :bad_request
        end

        def render_bad_request error
          render json: {error: error}, status: :bad_request
        end

        def render_record_not_found error
          render json: {error: error}, status: :not_found
        end

        def render_invalid_foreignkey error
          render json: {error: "Foreign Key Contstraint Error"}, status: :internal_server_error
        end
      end
    end
  end
end
