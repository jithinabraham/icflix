2.times do
  Tenant.create!(name: FFaker::Name.name, api_key: SecureRandom.urlsafe_base64)
end