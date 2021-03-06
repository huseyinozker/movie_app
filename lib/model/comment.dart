import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String user_id;
  String user_name;
  String user_nick;
  int movie_id;
  String comment;
  int like_count;

  Comment(
      {required this.id,
      required this.user_id,
      required this.user_name,
      required this.user_nick,
      required this.movie_id,
      required this.comment,
      required this.like_count});

  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    return Comment(
        id: snapshot.id,
        user_id: snapshot["user_id"],
        user_name: snapshot["user_name"],
        user_nick: snapshot["user_nick"],
        movie_id: snapshot["movie_id"],
        comment: snapshot["comment"],
        like_count: snapshot["like_count"]);
  }
}
