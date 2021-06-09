get '/content/:content_id/vuejs' do
  @content = Content.find(id: params[:content_id])
  @subtitles = @content.subtitles
  erb :'content/vuejs'
end

get '/content/:content_id/player' do
  @content = Content.find(id: params[:content_id])
  @subtitles = @content.subtitles
  @words_in_pos = @content.words_in_pos # pos => [words...]
  erb :'content/player'
end

get '/content/:content_id/download_subtitles' do
  @content = Content.find(id: params[:content_id])
  @content.download_subtitles
  redirect "/content/#{@content.id}"
end

get '/content/:content_id/subtitles' do
  @content = Content.find(id: params[:content_id])
  @subtitles = @content.subtitle_lines
  @words_in_pos = @content.words_in_pos # pos => [words...]
  erb :'content/subtitles'
end

get '/content/new' do
  erb :'content/form'
end

get '/content/:content_id/edit' do
  @content = Content.find(id: params[:content_id])
  erb :'content/form'
end

get '/content/:content_id/delete' do
  content = Content.find(id: params[:content_id])
  content.destroy
  redirect "/user/#{content.user_id}"
end

post '/content/save' do
  content = if params[:content_id]
      Content.find(id: params[:content_id])
    else
      Content.new
    end
  content.user_id = @current_user.id
  ['title', 'url', 'transcript'].each do |f_name|
    content[f_name] = params[f_name]
  end
  content.save
  redirect "/user/#{@current_user.id}"
end

get '/content/:content_id' do
  @content = Content.find(id: params[:content_id])
  erb :'content/show'
end
