require 'sinatra'
require 'sinatra/json'
require_relative "album"

helpers Sinatra::JSON

set :public_folder, "www/"

get '/' do
  send_file File.join(settings.public_folder, "index.html")
end

get '/albums/:artist_name' do
  albums = Album.of_artist(params[:artist_name])
  json albums.map(&:as_json)
end
