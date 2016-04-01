class AnswersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build
    respond_with(@answer)
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      redirect_to question_path(@question)
    else 
      render 'new'
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
