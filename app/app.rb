require "rubygems"
require "bundler/setup"
require "sinatra"

set :public_folder, File.dirname(__FILE__) + '/assets'

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
