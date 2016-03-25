class Answer < ActiveRecord::Base
  belongs_to :question
  belogns_to :user
end
