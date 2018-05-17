class Song
  attr_accessor :name, :artist_name
  @@all = []

  def initialize(name = nil, artist_name = nil)
    @name = name
    @artist_name = artist_name
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    return song if song
    self.create_by_name(name)
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def self.new_by_name(name)
    new_song = self.new
    new_song.name = name
    new_song
  end

  def self.create_by_name(name)
    self.new_by_name(name).save
    self.all.last
  end

  def self.create
    self.new.save
    self.all.last
  end

  def self.alphabetical
    self.all.sort {|song, song2| song.name <=> song2.name }
  end

  def self.new_from_filename(file)
    artist = file.split(" - ")
    song = artist[1].split(".").first
    artist = artist.first
    self.new(song, artist)
  end

  def self.create_from_filename(file)
    new_song = self.new_from_filename(file)
    new_song.save
  end

  def self.destroy_all
    self.all.clear
  end
end
