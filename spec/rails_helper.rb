require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'factory_bot'
require 'json_matchers/rspec'
require 'support/request_support.rb'
ActiveRecord::Migration.maintain_test_schema!
JsonMatchers.schema_root = "spec/support/api/schemas"
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Requests::JsonHelpers, type: :request

  # Database cleaner config
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    begin
      DatabaseCleaner.start
      FactoryBot.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include(Shoulda::Callback::Matchers::ActiveModel)
  
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Rails.application.routes.url_helpers
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
