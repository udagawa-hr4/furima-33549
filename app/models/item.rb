class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  with_options presence:true do
    validates :name
    validates :explanation
    validates :image
    validates :price,numericality: {only_integer: true}
    validates_inclusion_of :price, in: 300..9999999
    with_options numericality: {only_integer: true,greater_than_or_equal_to: 1} do
      validates :category_id
      validates :condition_id
      validates :postage_type_id
      validates :prefecture_id
      validates :preparation_day_id
    end
    
    
  end
  belongs_to :user
  has_one :purchase
  has_one_attached :image
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :condition
  
end
