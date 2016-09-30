# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create! name: "Tuan", email: "tuan@gmail.com", password: "111111",
  password_confirmation: "111111", is_admin: true
User.create! name: "user1", email: "1@gmail.com", password: "password",
  password_confirmation: "password", is_admin: false
Category.create! name: "cate1", description: "des"

categories = Category.all
categories.each do |category|
  5.times do |n|
    category.questions.build(
      content: "#{n}",
      question_type: 0).save
  end
  5.times do |n|
    category.questions.build(
      content: "#{n}",
      question_type: 1).save
  end
end

questions = Question.all
questions.single_choice.each do |question|
  question.answers.build(content: "Option 1",
    is_correct: true).save
  question.answers.build(content: "Option 2",
    is_correct: false).save
  question.answers.build(content: "Option 3",
    is_correct: false).save
  question.answers.build(content: "Option 4",
    is_correct: false).save
end

questions.multiple_choice.each do |question|
  question.answers.build(content: "Option 1",
    is_correct: true).save
  question.answers.build(content: "Option 2",
    is_correct: false).save
  question.answers.build(content: "Option 3",
    is_correct: true).save
  question.answers.build(content: "Option 4",
    is_correct: false).save
end

questions.text.each do |question|
  question.answers.build(content: "answer number 1",
    is_correct: true).save
  question.answers.build(content: "answer number 2",
    is_correct: false).save
  question.answers.build(content: "answer number 3",
    is_correct: true).save
  question.answers.build(content: "answer number 4",
    is_correct: false).save
end
