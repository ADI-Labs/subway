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
  
  def upvote
      @answer = Answer.find(params[:answer_id])
      @upvote = Upvote.find_by(answer_id: @answer.id, user_id: current_user.id)
      if @upvote 
          @upvote.destroy
      else
          Upvote.create(user_id: current_user.id, answer_id: @answer.id)
      end
      respond_to do |format|
        format.json { render json: @upvote}
      end
  end

  private
    def answer_params
      params.require(:answer).permit(:body)
    end
end
