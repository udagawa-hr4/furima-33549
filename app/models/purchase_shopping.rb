class PurchaseShopping

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id,:city,:address,:building_name,:phone_number,:token,:user_id,:item_id

  with_options presence: true do
    validates :postal_code,format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_id,numericality: {only_integer: true,greater_than_or_equal_to: 1}
    validates :phone_number,format: {with: /\A\d{10,11}\z/}
    validates :city,format: {with: /\A[ぁ-んァ-ン一-龥々]/}
    validates :address
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
     purchase = Purchase.create(user_id: user_id,item_id: item_id)
     ShoppingAddress.create(postal_code: postal_code,prefecture_id: prefecture_id,city: city,address: address,building_name: building_name,phone_number: phone_number,purchase_id: purchase.id)
  end
end




  
  