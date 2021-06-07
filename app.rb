require 'sinatra'
require "sinatra/reloader"
require "sequel"

DB = Sequel.connect("sqlite://database.db")

require_relative "models"
require_relative "controllers"

enable :sessions

before do
  if session[:user_id]
    @current_user = User.find(id: session[:user_id])
  end
end

get '/' do
  erb :main
end
