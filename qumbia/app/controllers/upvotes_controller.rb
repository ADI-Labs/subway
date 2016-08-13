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
    @upvote = @answer.upvotes.build
    respond_with(@upvote)
  end

  def create
    @answer = Answer.find(params[:answer_id].to_i)
    @upvote = @answer.upvotes.build(upvote_params)
    @upvote.user = current_user
    respond_to do |format|
      if @upvote.save
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
    @upvote = Upvote.find(params[:id])
    @upvote.destroy
    return
  end
  
  private
    def upvote_params
      params.require(:upvote).permit(:answer_id)
    end
end
