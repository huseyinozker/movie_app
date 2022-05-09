class Movie {
  final int id;
  final String name;
  final String poster_path;
  final String backdrop_path;
  final String overview;

  const Movie({
    required this.id,
    required this.name,
    required this.poster_path,
    required this.backdrop_path,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      poster_path: json['poster_path'],
      backdrop_path: json['backdrop_path'],
      overview: json['overview'],
    );
  }
  /* factory Movie.fromItems(){
    return(

    );
  } */
}
