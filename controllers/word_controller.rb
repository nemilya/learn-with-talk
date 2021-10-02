get '/words/:content_id/speech' do
  page = params[:p] || 1
  @content = Content.find(id: params[:content_id])
  @words_bunch = @content.words[(page.to_i-1)*10..(page.to_i*10-1)]

  @words = []
  @words_bunch.each do |word|
    w = word.word_and_pronunciation[0]
    @words << w
  end
  erb :'word/speech'
end

get '/words/:content_id/quiz' do
  page = params[:p] || 1
  @content = Content.find(id: params[:content_id])
  @words_bunch = @content.words[(page.to_i-1)*10..(page.to_i*10-1)]

  @words = []
  @words_bunch.each do |word|
    w = word.word_and_pronunciation[0]
    letters = w.split('').shuffle
    @words << {
      word: w,
      letters: letters
    }
  end
  @words.shuffle! unless params[:noshuffle]

  erb :'word/quiz'
end

get '/words/:content_id/check' do
  @content = Content.find(id: params[:content_id])
  @words = @content.words
  erb :'word/check'
end

get '/words/:content_id' do
  @content = Content.find(id: params[:content_id])
  @words = Word.where(content_id: @content.id).order(:subtitle_line_pos).all
  erb :'word/index'
end

get '/word/new' do
  @content = Content.find(id: params[:content_id])
  erb :'word/form'
end

get '/word/:word_id/edit' do
  @word = Word.find(id: params[:word_id])
  @content = @word.content
  erb :'word/form'
end

get '/word/:word_id/delete' do
  # todo check permission
  word = Word.find(id: params[:word_id])
  word.destroy
  redirect "/words/#{word.content_id}"
end

post '/word/save' do
  if params[:word_id]
    word = Word.find(id: params[:word_id])
  else
    word = Word.new
    word.content_id = params[:content_id]
    word.created_at = Time.now
  end
  ['word', 'translation'].each do |f_name|
    word[f_name] = params[f_name]
  end
  word.subtitle_line_pos = params[:subtitle_line_pos] if params[:subtitle_line_pos]
  word.save
  if params[:subtitle_line_pos]
    redirect "/content/#{word.content_id}/subtitles#line_index_#{params[:subtitle_line_pos]}"
  else
    redirect "/words/#{word.content_id}#word_#{word.id}"
  end
end

