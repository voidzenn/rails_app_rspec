class Api::V1::RolesController < Api::BaseController
  before_action :find_by_id, only: %i(show update destroy)

  def index
    role = Role.all

    return render json: { message: "Failed" }, status: 400 if role.empty?

    render json: { message: "Success", data: role }, status: 200
  end

  def show
    return render json: { message: "Failed" }, status: 400 if !@role

    render json: { message: "Success", data: @role }, status: 200
  end

  def create
    role = Role.new role_params

    return render json: { message: "Failed" }, status: 400 if !role.valid?

    role.save
    render json: { message: "Successfully created #{params[:name]}", data: role }, status: 200
  end

  def update
    @role.update role_params
    render json: { message: "Success" }, status: 200
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
    @role = Role.find params[:id]

    return render json: { message: "Failed role not found" }, status: 400 if !@role
  end
end
