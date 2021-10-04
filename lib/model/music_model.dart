class MusicModel{
  int trackId;
  int trackRating;
  int explicit;
  int albumId;
  int artistId;
  int lyricsId;
  String lyricsBody;
  String trackName;
  String albumName;
  String artistName;

  MusicModel({
    this.trackId,
    this.trackName,
    this.trackRating,
    this.explicit,
    this.albumId,
    this.artistId,
    this.albumName,
    this.artistName,
    this.lyricsBody,
    this.lyricsId
  });

  factory MusicModel.fromJson(Map<String, dynamic> json){
    return MusicModel(
      trackId: json['track_id'],
      trackName: json['track_name'],
      trackRating: json['track_rating'],
      explicit: json['explicit'],
      albumId: json['album_id'],
      albumName: json['album_name'],
      artistId: json['artist_id'],
      artistName: json['artist_name'],
      lyricsBody: json['lyrics_body'],
      lyricsId: json['lyrics_id']
    );
  }
}