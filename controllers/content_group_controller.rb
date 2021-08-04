get '/content_group/new' do
  erb :'content_group/form'
end

get '/content_group/:content_group_id/edit' do
  @content_group = ContentGroup.find(id: params[:content_group_id])
  erb :'content_group/form'
end

get '/content_group/:content_group_id/delete' do
  ContentGroup.find(id: params[:content_group_id]).destroy
  redirect "/user/#{content_group.user_id}"
end

post '/content_group/save' do
  content_group = if params[:content_group_id]
      ContentGroup.find(id: params[:content_group_id])
    else
      ContentGroup.new
    end
  content_group.user_id = @current_user.id # todo
  ['title'].each do |f_name|
    content_group[f_name] = params[f_name]
  end
  content_group.save
  redirect "/user/#{@current_user.id}"
end

