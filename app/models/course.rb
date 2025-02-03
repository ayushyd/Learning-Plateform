class Course < ApplicationRecord

	belongs_to :user, class_name: 'User'
	has_many :students, through: :enrollments, source: :user
	has_many :lessons
end
