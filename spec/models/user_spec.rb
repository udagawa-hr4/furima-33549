require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "ユーザー新規登録" do
    context "新規登録できるとき" do
      it "全ての情報が存在すれば登録できる" do
        @user.valid?
        expect(@user).to be_valid
      end
      it "nicknameが6文字以下であれば登録できる" do
        @user.nickname = "あいうえおぽ"
        @user.valid?
        expect(@user).to be_valid
      end
      it "passwordとpassword_confirmationが6文字以上であれば登録できる" do
        @user.password = "a23456"
        @user.password_confirmation = "a23456"
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context "新規登録できない時" do
      it "nicknameがない場合は登録できないこと" do
        @user.nickname = ""
        @user.valid?
        
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "passwordがない場合は登録できないこと" do
        @user.password = ""
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid", "Password is too short (minimum is 6 characters)", "Password can't be blank")
      end
      it "passwordとpassword_confirmationがマッチしないとき登録できないこと" do
       @user.password = "a123456"
       @user.password_confirmation = "b123456"
       @user.valid?
       expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
      end
      it "パスワードは、確認用を含めて2回入力すること" do
        @user.password = "abc123"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
      end
      it "passwordが5文字以下だと登録できないこと" do
        @user.password = "a1234"
        @user.password_confirmation = "a1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        
      end
      it "emailが空だと登録できないこと" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "メールアドレスには＠を含めないと登録できないこと" do
        @user.email = "a123456789"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "メールアドレスが一意性でないと登録できないこと"do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "family_nameが空だと登録できないこと" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it "family_nameが全角漢字、カタカナ、ひらがな以外は登録できないこと" do
        @user.family_name = "ｱｲｳ"
        @user.valid?
       
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it "first_nameが空だと登録できないこと" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "first_nameが全角漢字、カタカナ、ひらがな以外は登録できないこと" do
        @user.first_name = "ｱｲｳ"
        @user.valid?
        
        expect(@user.errors.full_messages).to include("First name is invalid")

      end


      it "read_firstが空だと登録できないこと"do
       @user.read_first = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("Read first can't be blank", "Read first is invalid")
      end
      it "read_familyが空だと登録できないこと"do
       @user.read_family = ""
       @user.valid?
       expect(@user.errors.full_messages).to include("Read family can't be blank", "Read family is invalid")
      end
      it "read_firstが全角カタカナ以外だと登録できないこと" do
       @user.read_first = "あいう"
       @user.valid?
       expect(@user.errors.full_messages).to include("Read first is invalid")
      end
      it "read_familyが全角カタカナ以外だと登録できないこと" do
        @user.read_family = "あいう"
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid")
      end
      it "birthdayが空だと登録できないこと" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end 
  end
end


RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context "トップページのテスト" do
    
    it "ログイン/ログアウト" do
      # トップページに移動する
      visit root_path
      # ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示されること
      expect(page).to have_content("ログイン")
      expect(page).to have_content("新規登録")
      # ヘッダーの新規登録/ログインボタンをクリックすることで、各ページに遷移できること
      click_link "ログイン"
      visit root_path
      click_link "新規登録"
      visit root_path
   
      # 正しいユーザー情報を入力する
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されること
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content("ログアウト")
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
      # ヘッダーのログアウトボタンをクリックすることで、ログアウトができること
      click_link "ログアウト"
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
    end
  end
end

