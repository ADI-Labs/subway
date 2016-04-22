class QuestionsController < ApplicationController
	skip_before_action :authenticate_user!
	
	before_action :check_auth

    def check_auth
       unless user_signed_in?
         redirect_to :controller => :welcome, :action => 'index'
       end
    end 

	def index
		@questions = Question.all
	end

	def show
		@question = Question.find(params[:id])
		@answers = @question.answers
	end

	def new
		@question = Question.new
	end

	def edit
		@question = Question.find(params[:id])
	end

	def create
		@question = Question.new(question_params)
		@question.user_id = current_user.id
		if @question.save
			redirect_to @question
		else
			render 'new'
		end
	end

	def update
		@question = Question.find(params[:id])

		if @question.update(question_params)
			redirect_to @question
		else
			render 'edit'
		end
	end

	def destroy
		@question = Question.find(params[:id])
		@question.destroy

		redirect_to questions_path
	end

	private
		def question_params
			params.require(:question).permit(:title, :text)
		end
end
