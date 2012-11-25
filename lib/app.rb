require 'sinatra'
require 'sinatra/json'
require_relative "album"

helpers Sinatra::JSON

get '/albums/:artist_name' do
  albums = Album.of_artist(params[:artist_name])
  json albums.map(&:as_json)
end
