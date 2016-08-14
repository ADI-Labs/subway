class VotesController < ApplicationController
  skip_before_action :authenticate_user!
  
  before_action :check_auth

  
    def check_auth
       unless user_signed_in?
         redirect_to :controller => :questions, :action => 'index'
       end
    end 
  
  def new
    @answer = Answer.find(params["answer_id"].to_i)
    @vote = @answer.votes.build
    respond_with(@vote)
  end

  def create
    @answer = Answer.find(params[:answer_id].to_i)
    @vote = @answer.votes.build(vote_params)
    @vote.user = current_user
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: "Save process completed!" }
        format.json { render json: @vote}
      else
        format.html { 
          flash.now[:notice]="Save proccess coudn't be completed!" 
          render :new 
        }
        format.json { render json: "Vote failed to post" }
      end
    end
  end
  
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    return
  end
  
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format| 
      if @vote.update(vote_params)
        format.html { redirect_to @vote }
        format.json { render json: @vote }
      else
        format.html { 
          flash.now[:notice]="Vote failed" 
          render :update 
        }
        format.json { render json: "Vote failed" }
      end
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:answer_id, :isUpvote)
    end
end
