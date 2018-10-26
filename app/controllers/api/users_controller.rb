class Api::UsersController < ApiController
  before_action :authenticated?

  def index
    return permission_denied_error unless conditions_met
    users = User.all
    render json: users, each_serializer: InsecureUserSerializer
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy
      render json: {}, status: :no_content # Return HTTP 204 No Content to indicate the server **successfully** processed the request but is not returning any content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  private
  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
