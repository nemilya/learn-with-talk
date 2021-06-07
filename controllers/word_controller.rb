get '/words/:content_id' do
  @content = Content.find(id: params[:content_id])
  @words = Word.where(content_id: @content.id).all
  erb :'word/index'
end

get '/word/new' do
  @content = Content.find(id: params[:content_id])
  erb :'word/form'
end

get '/word/:word_id/delete' do
  # todo check permission
  word = Word.find(id: params[:word_id])
  word.destroy
  redirect "/words/#{word.content_id}"
end

post '/word/save' do
  word = Word.new
  word.content_id = params[:content_id]
  ['word', 'translation'].each do |f_name|
    word[f_name] = params[f_name]
  end
  word.subtitle_line_pos = params[:subtitle_line_pos] if params[:subtitle_line_pos]
  word.save
  if params[:subtitle_line_pos]
    redirect "/content/#{word.content_id}/subtitles#line_index_#{params[:subtitle_line_pos]}"
  else
    redirect "/words/#{word.content_id}"
  end
end

