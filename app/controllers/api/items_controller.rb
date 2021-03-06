class Api::ItemsController < ApiController
  before_action :authenticated?

  def index 
    list = List.find(params[:list_id])
    items = list.items
    render json: items, each_serializer: ItemSerializer
  end  

  def create
    list = List.find(params[:list_id])
    item = list.items.build(item_params)

    if item.save
      render json: item.to_json
    else
      render json: {errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    list = List.find(params[:list_id])
    item = list.items.find(params[:id])
    if item.update_attributes(item_params)
      render json: item.to_json
    else
      render json: {errors: item.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:description, :completed, :priority)
  end

end