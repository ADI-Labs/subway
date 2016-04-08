# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
cameron = User.create! email: 'cra2126@columbia.edu', password: 'dog12345'
jessie = User.create! email:'jll2219@columbia.edu', password: 'catzcatz'
saahil = User.create! email: 'sj2675@columbia.edu', password: 'fluffyfluffy'

Question.destroy_all
ques1 = Question.create! title: 'what are dogs', text: 'are they tree', user_id: cameron.id
ques2 = Question.create! title: 'who is smart', text: 'is it cameron', user_id: saahil.id
ques3 = Question.create! title: 'Can I trust Sean', text: 'he seems slimy', user_id: cameron.id

Answer.destroy_all
ans1 = Answer.create! body: 'dogs are not trees', question_id: ques1.id, user_id: jessie.id
ans4 = Answer.create! body: 'to have more than one answer test', question_id: ques1.id, user_id: jessie.id
ans2 = Answer.create! body: 'it is cameron', question_id: ques2.id, user_id: jessie.id
ans3 = Answer.create! body: 'do not trust sean', question_id: ques3.id, user_id: saahil.id

