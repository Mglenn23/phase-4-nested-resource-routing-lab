class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user= user_find
      items =user.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end
  def show
    item = item_find
    render json: item
  end
  def create
    user = user_find
    item = user.items.create( params.permit(:name, :description, :price))
    render json: item, status: :created
  end

  private
  def user_find
    User.find(params[:user_id])
  end
  def item_find
    Item.find(params[:id])
  end
  def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end
end
