class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	has_and_belongs_to_many :categories
	belongs_to :user
end
