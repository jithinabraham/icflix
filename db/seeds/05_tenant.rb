2.times do
  Tenant.create(name: FFaker::Name.name)
end

keys =%w[pnf-Og17ylratySpeukB0w wVZsX5wxZ9o-4OB6MRklXQ]
Tenant.all.each_with_index do |tenant, i|
  tenant.update!(api_key: keys[i])
end