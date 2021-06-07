get '/users' do
  @users = User.all
  erb :'user/index'
end

get '/user/new' do
  erb :'user/form'
end

get '/user/:user_id/edit' do
  @user = User.find(id: params[:user_id])
  erb :'user/form'
end

post '/user/save' do
  user = if params[:user_id]
      User.find(id: params[:user_id])
    else
      User.new
    end
  user.name = params[:name]
  user.save
  redirect '/users'
end

get '/user/login_as/:user_id' do
  user = User.find(id: params[:user_id])
  session[:user_id] = user.id
  redirect "/user/#{user.id}"
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/user/:id' do
  #  @contents = Content.where(user_id: params[:id]).all
  @user = User.find(id: params[:id])
  erb :'user/show'
end
