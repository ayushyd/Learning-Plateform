class Lesson < ApplicationRecord
	belongs_to :course
	has_one :quize
end
