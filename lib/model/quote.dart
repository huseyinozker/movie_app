import 'package:cloud_firestore/cloud_firestore.dart';

class Quote {
  String id;
  String user_id;
  String user_name;
  String user_nick;
  int movie_id;
  String quote;
  int like_count;

  Quote(
      {required this.id,
      required this.user_id,
      required this.user_name,
      required this.user_nick,
      required this.movie_id,
      required this.quote,
      required this.like_count});

  factory Quote.fromSnapshot(DocumentSnapshot snapshot) {
    return Quote(
        id: snapshot.id,
        user_id: snapshot["user_id"],
        user_name: snapshot["user_name"],
        user_nick: snapshot["user_nick"],
        movie_id: snapshot["movie_id"],
        quote: snapshot["quote"],
        like_count: snapshot["like_count"]);
  }
}
