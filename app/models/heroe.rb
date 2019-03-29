class Heroe < ApplicationRecord
	self.per_page = 5
	belongs_to :universe
end
