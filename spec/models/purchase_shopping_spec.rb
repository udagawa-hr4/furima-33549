require 'rails_helper'

RSpec.describe PurchaseShopping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shopping= FactoryBot.build(:purchase_shopping,user_id: user.id,item_id: item.id)
    sleep 0.1
 end
 describe '購入機能' do
    context '購入できるとき' do
      it '全ての入力情報が正しく入力されていれば登録できること' do
        @purchase_shopping.valid?
        expect(@purchase_shopping).to be_valid
      end
      it 'building_nameは空でも登録できること' do
        @purchase_shopping.building_name = ""
        @purchase_shopping.valid?
        expect(@purchase_shopping).to be_valid
      end
    end
    context '購入できないとき' do
      it "クレジットカード情報に不備があると登録できないこと" do
        @purchase_shopping.token = ""
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Token can't be blank")
      end
      it "postal_codeがないと登録できないこと" do
        @purchase_shopping.postal_code = ""
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid")
      end
      it "postal_codeは半角数字で「123-4567」のようにハイフンが必要であること" do
        @purchase_shopping.postal_code = "1234567"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid")
      end
      it "postal_codeは全角数字では登録できないこと" do
        @purchase_shopping.postal_code = "１２３ー４５６７" 
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid")
      end
      it "postal_codeは「半角数字３桁-半角数字４桁」以外の形だと登録できないこと" do
        @purchase_shopping.postal_code = "1234-567"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Postal code is invalid")
      end

      it "prefecture_idが-「--- (id=0)」のままだと登録できないこと" do
        @purchase_shopping.prefecture_id = 0
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Prefecture must be greater than or equal to 1")
      end
      it "cityは全角平仮名、カタカナ、漢字以外では登録できないこと(半角カタカナの場合)" do
        @purchase_shopping.city = "ｱｲｳｴｵ"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("City is invalid")
      end
      it "cityは全角平仮名、カタカナ、漢字以外では登録できないこと(ローマ字の場合)" do
        @purchase_shopping.city = "abcde"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("City is invalid")
      end
      it "cityは全角平仮名、カタカナ、漢字以外では登録できないこと(数字の場合)" do
        @purchase_shopping.city = "12345"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("City is invalid")
      end
      it "cityは空だと登録できないこと" do
        @purchase_shopping.city = ""
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("City can't be blank", "City is invalid")
      end
      it "addressが空だと登録できないこと" do
        @purchase_shopping.address = ""
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Address can't be blank")
      end
      it "phone_numberは空だと登録できないこと" do
        @purchase_shopping.phone_number = ""
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid")
      end
      it "phone_numberは全角数字では登録できないこと" do
        @purchase_shopping.phone_number = "０９０１２３４５６７８"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberは半角数字以外だと登録できないこと(半角カタカナ)" do
        @purchase_shopping.phone_number = "ｱｲｳｴｵｶｷｸｹｺ"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberは半角数字以外だと登録できないこと(半角ローマ字)" do
        @purchase_shopping.phone_number = "abcdefghij"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberは半角数字以外だと登録できないこと(全角ローマ字)" do
        @purchase_shopping.phone_number = "ａｂｃｄｅｆｇｈｉｊｋ"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
      end
      it "phone_numberは半角数字10桁11桁でないと登録できないこと(9桁)" do
        @purchase_shopping.phone_number ="123456789"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")

      end
      it "phone_numberは半角数字10桁11桁でないと登録できない(12桁)" do
        @purchase_shopping.phone_number ="123456789012"
        @purchase_shopping.valid?
        expect(@purchase_shopping.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end