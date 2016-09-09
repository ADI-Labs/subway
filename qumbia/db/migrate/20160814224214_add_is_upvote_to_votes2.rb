class AddIsUpvoteToVotes2 < ActiveRecord::Migration
  def change
  	add_column :votes, :isUpvote, :boolean
  end
end
