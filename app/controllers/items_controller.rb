class ItemsController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show]
  before_action :find_params,only: [:show,:edit,:update,:destroy]
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
   end
   def edit
     unless user_signed_in? && current_user.id == @item.user.id
      redirect_to action: :index
    end

   end
  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end
    def destroy
     if user_signed_in? && current_user.id == @item.user.id
       @item.destroy
       redirect_to action: :index
     else
       redirect_to action: :index
     end
    end
  private
  def item_params
    params.require(:item).permit(:name,:category_id,:condition_id,:postage_type_id,:prefecture_id,:preparation_day_id,:explanation,:price,:image,).merge(user_id: current_user.id)
  end
  def find_params
    @item = Item.find(params[:id])
  end
end
