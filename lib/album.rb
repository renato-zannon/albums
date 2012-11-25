require 'musicbrainz'
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
