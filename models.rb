['user', 'content', 'content_group', 'word'].each do |model_name|
  require_relative "models/#{model_name}"
end
