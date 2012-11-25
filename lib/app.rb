require 'sinatra'
require 'sinatra/json'
require 'musicbrainz'

helpers Sinatra::JSON

MusicBrainz::Tools::Cache.cache_path = "/tmp/musicbrainz-cache"

class Album
  def self.of_artist(artist_name)
    artist = MusicBrainz::Artist.find_by_name(artist_name)
    groups = artist.release_groups.select { |group| group.type == "Album" }

    groups.map { |group| new(artist_name, group) }
  end

  def initialize(artist_name, mb_release_group)
    @artist_name = artist_name

    most_relevant_release = mb_release_group.releases.max do |group|
      group.tracks.count
    end

    @title  = most_relevant_release.title
    @tracks = most_relevant_release.tracks
  end

  attr_reader :artist_name, :title, :tracks
end

get '/albums/:artist_name' do
  artist = MusicBrainz::Artist.find_by_name(params[:artist_name])
  albums = artist.release_groups.select { |group| group.type == "Album" }

  json albums.map(&:title).reverse
end
