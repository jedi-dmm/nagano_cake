class Post < ApplicationRecord

  VALID_POSTCODE = /\A\d{7}\z/

  validates :address, presence: true
  validates :name, presence: true
  validates :postcode, presence: true

end