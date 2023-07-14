class Api::V1::BaseController < ApplicationController
  protect_from_forgery 

  include Api::V1::BaseConcern
end