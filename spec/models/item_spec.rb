require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item,user_id: user.id)
  end
  describe '出品機能' do
    context '出品できるとき' do
      it '全ての情報があれば保存できること'do
        @item.valid?
        expect(@item).to be_valid
      end

    end
    context '出品に失敗するとき' do
      it '画像がないと保存できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameがないと保存できないこと' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'explanationがないと登録できないこと' do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it 'category_idがないと登録できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
      end
      it 'condition_idがないと登録できないこと' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank", "Condition is not a number")
      end
      it 'postage_type_idがないと登録できないこと' do
        @item.postage_type_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage type can't be blank", "Postage type is not a number")
      end
      it 'prefecture_idがないと登録できないこと' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
      end
      it 'preparation_day_idがないと登録できないこと' do
        @item.preparation_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Preparation day can't be blank", "Preparation day is not a number")
      end
      it 'priceがないと登録できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number", "Price is not included in the list")
      end
      
      it 'priceは半角数字出ないと登録できないこと' do
        @item.price = "１２"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number", "Price is not included in the list")
      end
      it 'category_idのid=0は登録できないこと' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be greater than or equal to 1")
      end
      it 'condition_idのid=0は登録できないこと' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be greater than or equal to 1")
      end
      it 'preparation.day_idのid=0は登録できないこと' do
        @item.preparation_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Preparation day must be greater than or equal to 1")
      end
      it 'prefecture_idのid=0は登録できないこと' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be greater than or equal to 1")
      end
      it 'postage_type_idのid=0は登録できないこと' do
        @item.postage_type_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage type must be greater than or equal to 1")
      end
      it 'priceが299円以下の場合登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end
      it 'priceが10000000円以上の場合は登録できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end
      it 'priceが全角文字では登録できないこと' do
        @item.price = "アイウエオ"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number", "Price is not included in the list")
      end
      it 'priceが半角英数混合では登録できないこと' do
        @item.price = "abc123"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number", "Price is not included in the list")
      end
      it 'priceが半角英語だけでは登録できないこと' do
        @item.price = "abcdef"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number", "Price is not included in the list")
      end

    end

  end
end