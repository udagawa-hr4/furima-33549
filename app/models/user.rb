class User < ApplicationRecord
  
 
  with_options presence:true do
    validates :nickname
    validates :birthday

    with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/} do
      validates :first_name
      validates :family_name
    end
    
    with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :read_first
      validates :read_family
    end

    VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
    validates :password, format: { with: VALID_PASSWORD_REGEX },length: { minimum: 6}
  end

  has_many :items
  has_many :purchases

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
end
