class Api::V1::RolesController < Api::BaseController
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

    if role.valid? and role.save
      render json: { message: "Successfully created #{params[:name]}", data: role }, status: 200
    else
      invalid_message role
    end
  end

  def update
    if @role.valid? and @role.update role_params
      render json: { message: "Success" }, status: 200
    else
      invalid_message @role
    end
  end

  def destroy
    return render json: { message: "Success" }, status: 200 if @role.delete
  rescue ActiveRecord::InvalidForeignKey => e
        render json: { message: "Cannot delete role", error_message: e }, status: 422
  end

  private
  def role_params
    params.require(:role).permit(:name)
  end

  def find_by_id
    @role ||= Role.find params[:id]
  rescue ActiveRecord::RecordNotFound => e
        render json: { message: "Failed role not found", error_message: e }, status: 404
  end

  def invalid_message data
    render json: { error_message: data.errors.full_messages }, status: 400
  end
end
