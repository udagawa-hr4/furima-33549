class PurchasesController < ApplicationController
  before_action :authenticate_user!,only: [:index,:create]
  before_action :find_params,only: [:index,:create]
  def index
    @purchase_shopping = PurchaseShopping.new
   if  @item.purchase != nil || @item.user_id ==current_user.id
       redirect_to root_path
    end
  end
  def create
    @purchase_shopping = PurchaseShopping.new(purchase_params)
    if @purchase_shopping.valid?
          
      pay_item
      @purchase_shopping.save
      redirect_to root_path
    else
      render action: :index
    end
  end

    private
    def purchase_params
      params.require(:purchase_shopping).permit(:postal_code,:prefecture_id,:city,:address,:building_name,:phone_number).merge(user_id: current_user.id,item_id: params[:item_id],token: params[:token])
    end
    def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token] ,
        currency: 'jpy',       
      )
    end
    def find_params
      @item = Item.find(params[:id])
    end
end
