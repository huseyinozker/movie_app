import 'package:movie_app/class/movie.dart';

class MovieList {
  final String id;
  final String name;
  final List<Movie> items;

  const MovieList({
    required this.id,
    required this.name,
    required this.items,
  });

  factory MovieList.fromJson(
      Map<String, dynamic> json, List<dynamic> jsonItems) {
    List<Movie> deneme = jsonItems.map((item) => Movie.fromJson(item)).toList();
    return MovieList(
      id: json['id'],
      name: json['name'],
      items: deneme,
    );
  }
}
