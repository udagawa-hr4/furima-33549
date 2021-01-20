class ItemsController < ApplicationController
  before_action :authenticate_user!,only: [:new]
  def index
    @item = Item.includes(:user).order("created_at DESC")
  end
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index 
    else
      render :new
    end
  end
   def show
     @item = Item.find(params[:id])
   end
   def edit
     @item = Item.find(params[:id])
   end
   def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end

   end
  private
  def item_params
    params.require(:item).permit(:name,:category_id,:condition_id,:postage_type_id,:prefecture_id,:preparation_day_id,:explanation,:price,:image,).merge(user_id: current_user.id)
  end
end
