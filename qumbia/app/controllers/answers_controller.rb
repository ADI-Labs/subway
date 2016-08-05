class AnswersController < ApplicationController
  skip_before_action :authenticate_user!
  
  before_action :check_auth

  
    def check_auth
       unless user_signed_in?
         redirect_to :controller => :questions, :action => 'index'
       end
    end 
  
  def new
    @question = Question.find(params["question_id"].to_i)
    @answer = @question.answers.build
    respond_with(@answer)
  end

  def create
    @question = Question.find(params[:question_id].to_i)
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: "Save process completed!" }
        format.json { render json: @answer}
      else
        format.html { 
          flash.now[:notice]="Save proccess coudn't be completed!" 
          render :new 
        }
        format.json { render json: "Answer failed to post" }
      end
    end
  end
  
  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to article_path(@question)
  end
  
  private
    def answer_params
      params.require(:answer).permit(:body)
  end
end
