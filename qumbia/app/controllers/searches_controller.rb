class SearchesController < ApplicationController

	def index
		@q = "%#{params[:query]}%"
		@questions = Question.where("title LIKE ? or text LIKE ?", @q, @q)
		@answers = Answer.where("body LIKE ?", @q)
		@users = User.where("email LIKE ?", @q)
	end

	def search_questions
		@q = "%#{params[:query]}%"
		@questions = Question.where("title LIKE ? or text LIKE ?", @q, @q)
	end

	def search_answers
		@q = "%#{params[:query]}%"
		@answers = Answer.where("body LIKE?", @q)
	end

	def search_categories
		@q = "%#{params[:query]}%"
		@categories = Category.where("name LIKE?", @q)
	end

end
