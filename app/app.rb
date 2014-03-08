#encoding: utf-8

require "rubygems"
require "bundler/setup"
require "sinatra"
require "sinatra/reloader" if development?
require "sequel"
require "yaml"
require "digest"
require "csv"

set :public_folder, File.dirname(__FILE__) + '/assets'

DB = Sequel.sqlite "#{settings.environment}.db"

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized!\n"
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && authenticate(*@auth.credentials)
  end
end

def authenticate(user, pass)
  users = YAML.load_file "users.yml"
  pass_digest = Digest::SHA256.hexdigest pass
  if users[user] && users[user] == pass_digest
    true
  else
    false
  end
end

# ---------- routes -----------

get "/" do
  erb :index
end

get "/eloadok" do
  erb :speakers
end

get "/info" do
  @container_class = 'thin-container'
  erb :info
end

get "/kapcsolat" do
  erb :contact
end

get "/partnerek" do
  erb :partners
end

get "/program" do
  @container_class = 'thin-container'
  erb :program
end

get "/regisztracio" do
  erb :signup
end

post "/regisztracio" do
  # check required fields
  if [:name, :organization, :email].all? { |field| !params[field].empty? }
    DB[:attendees].insert params
    erb :reg_success
  else
    @error = true
    erb :signup
  end
end

get '/results' do
  protected!
  @attendees = DB[:attendees].all

  erb :results
end

get '/csv' do
  protected!

  headers "Content-Disposition" => "attachment;filename=meetup-signup-results.csv"
  content_type "text/csv"

  CSV.generate do |csv|
    csv << %w(Név Szervezet Email Telefon)
    DB[:attendees].select_map([:name, :organization, :email, :phone]).each do |a|
      csv << a
    end
  end
end
