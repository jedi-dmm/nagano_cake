class Post < ApplicationRecord

  belongs_to :customer

  VALID_POSTCODE = /\A\d{7}\z/

  validates :customer_id, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :postcode, presence: true, format: { with: VALID_ZIP_CODE,message: "はハイフンなし7桁で入力してください。"}

end