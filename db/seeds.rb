# if Rails.env == 'development'
  Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each do |seed|
    puts "Running #{seed}"
    load seed
  end
# end