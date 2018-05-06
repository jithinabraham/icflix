5.times do 
  User.create!(name: FFaker::Name.name)
end