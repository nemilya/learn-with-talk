['user_controller', 'content_group_controller', 'content_controller', 'word_controller'].each do |controller_name|
  require_relative "controllers/#{controller_name}.rb"
end
