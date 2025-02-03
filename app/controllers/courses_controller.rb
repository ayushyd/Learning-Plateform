class CoursesController < ApplicationController

	def index
		@courses = Course.all
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.new(course_params)
		if @course.save 
			redirect_to 
		else 
		
		   render :new, status: :unprocessable_entity
		end	
	end

	def edit
	end

	def update
		if @course.update(course_params)
			redirect_to 
		else
		
		   render: :edit, status: :unprocessable_entity
		end 	

	end

	def destroy
		if @course.present?
			@course.delete

			redirect_to 

		end
	end

	private

	def course_params
		params.require(:course).permit(:title, :description, :instructor_id)
	end

	def set_course
		@course = Course.find(params[:id])
	end
end
