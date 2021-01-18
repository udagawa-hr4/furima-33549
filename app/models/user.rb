class User < ApplicationRecord
  
 
  
  validates :nickname, presence: true

  with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/} do
    validates :first_name, presence: true
    validates :family_name, presence: true
  end
  
  with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
    validates :read_first, presence: true
    validates :read_family, presence: true
  end

  validates :birthday, presence: true
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX },length: { minimum: 6}

  has_many :items
  has_many :purchases

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
end
