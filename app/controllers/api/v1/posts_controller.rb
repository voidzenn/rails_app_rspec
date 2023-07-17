class Api::V1::PostsController < Api::V1::BaseController
  before_action :find_post, only: %i(show update destroy)

  def index
    posts ||= Post.all
    render json: {message: "Success", data: posts}, status: 200
  end

  def show
    render json: {message: "Success", data: @post}
  end

  def create
    post = Post.create post_params
    render json: {message: "Success saved post", data: post}, status: 200
  end

  def update
    @post.update post_params
    render json: {message: "Successfully updated post", data: @post}, status: 200
  end

  def destroy
    @post.delete
    render json: {message: "Successfully deleted post"}, status: 200
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def find_post
    @post = Post.find params[:id]
  end
end
