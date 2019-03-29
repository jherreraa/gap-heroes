class Universe < ApplicationRecord
	self.per_page = 5
	has_many :heroes, dependent: :destroy
end
