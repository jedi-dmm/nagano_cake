class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :oders, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :posts, dependent: :destroy




   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_KATAKANA = /\A[\p{katakana}\p{blank}ー－]+\z/
  VALID_POSTCODE = /\A\d{7}\z/  # 郵便番号（ハイフンなし7桁）
  VALID_TEL = /\A\d{10,11}\z/   # 電話番号（ハイフンなし11桁　固定電話の場合ハイフンなし10桁）
  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :last_name_kana,  format: {
                                  with: VALID_KATAKANA,
                                  message: 'はカタカナで入力してください。'
                                }
    validates :first_name_kana, format: {
                                  with: VALID_KATAKANA,
                                  message: 'はカタカナで入力してください。'
                                }
    validates :postcode,        format: {
                                  with: VALID_POSTCODE,
                                  message: "はハイフンなし7桁で入力してください。"
                                }
    validates :address
    validates :tel,             format: {
                                  with: VALID_TEL,
                                  message: "の入力が間違っています（ハイフンなしの数字）"
                                }
    validates :email,           format: {
                                  with: VALID_EMAIL_REGEX
                                }
  end





end
