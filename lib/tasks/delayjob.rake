namespace :delayjob do
  desc "TODO"
  task statisticmonth: :environment do
    User.all.each do |user|
      question_count = User.question_learned user
      MonthlyWorker.perform_async user.id, question_count
    end
  end
end
