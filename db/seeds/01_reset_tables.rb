models = %w[users questions answers tenants]

models.reverse.each do |model|
  model.classify.constantize.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!(model)
end