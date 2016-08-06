class UpvotesController < ApplicationController
  skip_before_action :authenticate_user!
  
  before_action :check_auth

  
    def check_auth
       unless user_signed_in?
         redirect_to :controller => :questions, :action => 'index'
       end
    end 
  
  def new
    @answer = Answer.find(params["answer_id"].to_i)
    @upvote = @answer.build
    respond_with(@answer)
  end

  def create
    @answer = Answer.find(params[:answer_id].to_i)
    @upvote = @answer.upvotes.build(upvote_params)
    @upvote.user = current_user
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @upvote, notice: "Save process completed!" }
        format.json { render json: @upvote}
      else
        format.html { 
          flash.now[:notice]="Save proccess coudn't be completed!" 
          render :new 
        }
        format.json { render json: "Upvote failed to post" }
      end
    end
  end
  
  def destroy
    @answer = Answer.find(params[:answer_id])
    @upvote = @answer.upvotes.find(params[:id])
    @upvote.destroy
    redirect_to question_answer_path(@question.answer, @answer)
  end
  
  private
    def upvote_params
      params.require(:upvote).permit(:answer_id)
    end
end
