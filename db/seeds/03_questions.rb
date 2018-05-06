User.find_each do |user|
  user.questions.create!(description: Faker::Bank.swift_bic, )
end