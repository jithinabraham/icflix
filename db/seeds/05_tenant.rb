2.times do
  Tenant.create(name: Faker::Name.first_name)
end