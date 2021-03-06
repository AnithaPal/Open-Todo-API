class Api::ListsController < ApiController
  before_action :authenticated?

  def index
    user = User.find(params[:user_id])
    lists = user.lists
    render json: lists, each_serializer: ListSerializer
  end  

  def create
    user = User.find(params[:user_id])
    list = user.lists.build(list_params)
    if list.save
      render json: list.to_json
    else
      render json: {errors: list.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:user_id])
    list = user.lists.find(params[:id])
    if list.update_attributes(list_params)
      render json: list.to_json
    else
      render json: {errors: list.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      user = User.find(params[:user_id])
      list = user.lists.find(params[:id])
      list.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found
    end
  end

private

  def list_params
    params.require(:list).permit(:name, :permission)
  end

end