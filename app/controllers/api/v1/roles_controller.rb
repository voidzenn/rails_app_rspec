class Api::V1::RolesController < Api::V1::BaseController
  before_action :find_by_id, only: %i(show update destroy)

  def index
    role ||= Role.all
    render json: { message: "Success", data: role }, status: 200
  end

  def show
    render json: { message: "Success", data: @role }, status: 200
  end

  def create
    role ||= Role.new role_params

    raise ActionController::BadRequest.new(role.errors.full_messages) unless role.valid?

    render json: { message: "Successfully created #{params[:name]}", data: role }, status: 200
  end

  def update
    raise ActionController::BadRequest.new(@role.errors.full_messages) unless @role.valid?

    @role.update role_params
    render json: { message: "Successfully updated role", data: @role }, status: 200
  end

  def destroy
    @role.delete
    render json: { message: "Success" }, status: 200
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def find_by_id
    @role ||= Role.find params[:id]
  end
end
