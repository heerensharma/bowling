class Throw < ActiveRecord::Base
	validates :pins_down , numericality: { only_integer: true, greater_than: -1, less_than: 11}
end
