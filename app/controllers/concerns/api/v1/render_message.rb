module Api
  module V1
    module RenderMessage
      extend ActiveSupport::Concern

      included do
        def render_invalid_message msg
          render json: msg, status: 400
        end
      end
    end
  end
end