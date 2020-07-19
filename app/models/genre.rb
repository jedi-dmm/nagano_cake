class Genre < ApplicationRecord
	has_many :products,dependent: :destroy
	validates :name, presence: true, uniqueness: true #unique: trueはmigrateに記載
end
