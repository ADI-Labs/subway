class QuestionsController < ApplicationController
	respond_to :html, :json

	def index
		@questions = Question.all
		@questions_json =  @questions.to_json( 
			:include=> 
			[
					{:user => 
						{
							:only => [:email, :id]
						}
					},
					{:answers => 
						{ 
							:include => [
											:votes, 
											{:user => {:only => [:email, :id]}}
									    ], 
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
		respond_with @question
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
	  @question = Question.find(params[:id].to_i)
	  respond_to do |format|
	    if @question.user.id == current_user.id
	      @question.destroy
	      format.html { return }
	      format.json { head :no_content }
	    else
	      format.html { 
	        flash.now[:notice]="You don't have permission to perform this action" 
	      }
	      format.json { render json: "You don't have permission to perform this action"}
	    end
	  end
	end

	private
		def question_params
			params.require(:question).permit(:title, :text)
		end
end
