class QuestionsController < ApplicationController
	respond_to :html, :json

	def index
		@questions = Question.all
		@questions_json =  @questions.to_json( 
			:include=> 
			[
					{:user => 
						{
							:only => [:email]
						}
					},
					{:answers => 
						{ 
							:include => {:user => {:only => [:email]}}, 
							:except => [:created_at, :updated_at, :user_id]
						}
					},
					{:categories =>
						{
							:only => [:name]
						}
					}
			],
			:except=> 
			[
				:created_at, :updated_at, :user_id
			]
		)
		respond_with @questions_json
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
