class Api::V1::PostsController < ApplicationController
  def index
    posts ||= Post.all

    render json: { message: "Success", data: posts }, status: 200
  end
end
