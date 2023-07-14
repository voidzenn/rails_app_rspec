module Api
  module V1
    module BaseConcern
      extend ActiveSupport::Concern

      include Api::V1::RescueException
    end
  end
end