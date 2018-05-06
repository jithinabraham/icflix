Rails.application.config.middleware.use ApiIntervalLimitter unless Rails.env.test?
