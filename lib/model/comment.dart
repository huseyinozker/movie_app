import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String user_id;
  int movie_id;
  String comment;
  int like_count;

  Comment(
      {required this.id,
      required this.user_id,
      required this.movie_id,
      required this.comment,
      required this.like_count});

  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    return Comment(
        id: snapshot.id,
        user_id: snapshot["user_id"],
        movie_id: snapshot["movie_id"],
        comment: snapshot["comment"],
        like_count: snapshot["like_count"]);
  }
}
