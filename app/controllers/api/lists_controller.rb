class Api::ListsController < ApiController
  before_action :authenticated?

  def index
    return permission_denied_error unless conditions_met
    lists = List.all
    render json: lists, each_serializer: ListSerializer
  end

  def create
    list = List.new(list_params)
    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    list = List.find(params[:id])
    if list.update(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy
      render json: {}, status: :no_content # Return HTTP 204 No Content to indicate the server **successfully** processed the request but is not returning any content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  private
  def conditions_met
    true
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
