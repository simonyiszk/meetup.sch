require "rubygems"
require "bundler/setup"
require "sinatra"
require "sinatra/reloader" if development?
require "sequel"

set :public_folder, File.dirname(__FILE__) + '/assets'

# TODO: set production db
DB = Sequel.sqlite "#{settings.environment}.db"

get "/" do
  erb :index
end

get "/eloadok" do
  erb :speakers
end

get "/info" do
  erb :info
end

get "/kapcsolat" do
  erb :contact
end

get "/partnerek" do
  erb :partners
end

get "/regisztracio" do
  erb :signup
end

post "/reg" do
  # check required fields
  if [:name, :organization, :email].all? { |field| !params[field].empty? }
    DB[:attendees].insert params
    erb :reg_success
  else
    @error = true
    erb :signup
  end
end
