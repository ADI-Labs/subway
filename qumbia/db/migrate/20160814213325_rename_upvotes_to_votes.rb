class RenameVotesToVotes < ActiveRecord::Migration
  def change
  	rename_table :votes, :votes
  end
end
