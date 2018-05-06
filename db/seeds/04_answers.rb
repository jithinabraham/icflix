Question.find_each do |question|
  (1..5).to_a.sample.times do
    question.answers.create!(description: FFaker::Book.title, provider: User.all.sample)
  end
  (1..3).to_a.sample.times do
    question.answers.create!(description: FFaker::Book.title, provider: User.all.sample, is_personal: true)
  end
end