class User < ApplicationRecord
  
 
  
  validates :nickname, presence: true,length: {maximum: 6}
  validates :first_name, presence: true, format: { with: /\A^[ぁ-んァ-ヶー一-龠]+/}
  validates :family_name, presence: true, format:{  with: /\A^[ぁ-んァ-ヶー一-龠]+/}
  validates :read_first, presence: true,format: { with:  /[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+/ }
  validates :read_family, presence: true,format: { with: /[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+/ }
  validates :birthday, presence: true
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])[a-z\d]+\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX },length: { minimum: 6}
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  has_many :items
  has_many :purchases

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
end
