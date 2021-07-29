require 'sinatra'
require "sinatra/reloader"
require "sinatra/config_file"

require "sequel"

config_file 'config.yml'

DB = Sequel.connect("sqlite://database.db")

require_relative "models"
require_relative "controllers"

use Rack::Session::Cookie, :key => 'learn-with-talk',
                           :path => '/',
                           :secret => settings.secret

before do
  if session[:user_id]
    @current_user = User.find(id: session[:user_id])
  end
end

get '/' do
  erb :main
end
