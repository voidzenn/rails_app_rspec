class Api::V1::UsersController < Api::V1::BaseController
  before_action :find_by_id, only: %i(show update destroy)

  def index
    users ||= User.all
    render json: { message: "Success", data: users }, status: 200
  end

  def show
    render json: { message: "Success", data: @user }, status: 200
  end

  def create
    user ||= User.new user_params

    raise ActionController::BadRequest.new(user.errors.full_messages) unless user.valid?

    user.save
    render json: {
      message: "Successfully created #{user.fname + " " + user.lname}",
      data: user
    }, status: 200
  end

  def update
    raise ActionController::BadRequest.new(@user.errors.full_messages) unless @user.valid?

    @user.update user_params
    render json: { message: "Success", data: @user }, status: 200
  end

  def destroy
    @user.delete
    render json: { message: "Success", data: @user }, status: 200
  end

  private
  def user_params
    params.require(:user).permit(:fname, :lname, :age, :location, :role_id)
  end

  def find_by_id
    @user ||= User.find params[:id]
  end
end
