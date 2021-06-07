['user', 'content', 'word'].each do |model_name|
  require_relative "models/#{model_name}"
end
