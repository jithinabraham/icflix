User.find_each do |user|
  user.questions.create!(description: FFaker::Book.title)
end