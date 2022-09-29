class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else 
      items = Item.all
    end 
    render json: items, include: :user
  end

  def create 
    item = Item.create(items_params)
    render json: item, status: :created
  end 

  def show 
    item = Item.find(params[:id])
    render json: item, include: :user 
  end 

  private 

  def render_response_not_found
    render json: { error: "User not found" }, status: :not_found 
  end 

  def items_params
    params.permit(:name, :user_id, :description, :price)
  end 
end
