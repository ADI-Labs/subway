# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Question.destroy_all
ques1 = Question.create! title: 'what are dogs', text: 'are they trees'
ques2 = Question.create! title: 'who is smart', text: 'is it cameron'
ques3 = Question.create! title: 'Can I trust Sean', text: 'he seems slimy'

Answer.destroy_all
ans1 = Answer.create! body: 'dogs are not trees', question_id: ques1.id
ans4 = Answer.create! body: 'to have more than one answer test', question_id: ques1.id
ans2 = Answer.create! body: 'it is cameron', question_id: ques2.id
ans3 = Answer.create! body: 'do not trust sean', question_id: ques3.id

