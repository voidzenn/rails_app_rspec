class Api::V1::PostsController < Api::V1::BaseController
  def index
    posts ||= Post.all

    render json: { message: "Success", data: posts }, status: 200
  end

  def create
    post = Post.create post_params

    if post.save
      render json: { message: "Success saved post", data: post }, status: 200
    else
      render_invalid_message post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
