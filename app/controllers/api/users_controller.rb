class Api::UsersController < ApiController

  def index
    return permission_denied_error unless conditions_met
    users = User.all
    render json: users, each_serializer: InsecureUserSerializer
  end

  def show
    render json: {
      id: @user.id,
      username: @user.username,
      password: @user.password,
      list: @user.list
    }
  end

  private

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end

end
