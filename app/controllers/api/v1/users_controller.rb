class Api::V1::UsersController < Api::BaseController
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

    if user.valid? and user.save
      render json:
                {
                  message: "Successfully created #{user.fname + " " + user.lname}",
                  data: user
                }, status: 200
    else
      invalid_message user
    end
  end

  def update
    if @user.valid? and @user.update user_params
      render json: { message: "Success", data: @user }, status: 200
    else
      invalid_message @user
    end
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

    rescue ActiveRecord::RecordNotFound => e
          render json: { message: "Failed user not found", error_message: e }, status: 404
  end

  def invalid_message data
    render json: { error_message: data.errors.full_messages }, status: 400
  end
end
