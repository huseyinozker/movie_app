import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/model/comment.dart';

class CommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Comment> addComment(
    String choose,
    String user_id,
    String user_name,
    String user_nick,
    int movie_id,
    String comment,
    int like_count,
  ) async {
    if (choose == "Yorum") {
      var _comRef = _firestore.collection("Comment");

      like_count = 0;

      var documentRef = await _comRef.add({
        "user_id": user_id,
        "user_name": user_name,
        "user_nick": user_nick,
        "comment": comment,
        "movie_id": movie_id,
        "like_count": like_count
      });

      return Comment(
          id: documentRef.id,
          user_id: user_id,
          user_name: user_name,
          user_nick: user_nick,
          movie_id: movie_id,
          comment: comment,
          like_count: like_count);
    } else if (choose == "Alıntı") {
      var _qRef = _firestore.collection("Quotes");

      like_count = 0;

      var documentRef = await _qRef.add({
        "user_id": user_id,
        "user_name": user_name,
        "user_nick": user_nick,
        "comment": comment,
        "movie_id": movie_id,
        "like_count": like_count
      });

      return Comment(
          id: documentRef.id,
          user_id: user_id,
          user_name: user_name,
          user_nick: user_nick,
          movie_id: movie_id,
          comment: comment,
          like_count: like_count);
    }
    return Comment(
        id: "s",
        user_id: user_id,
        user_name: user_name,
        user_nick: user_nick,
        movie_id: movie_id,
        comment: comment,
        like_count: like_count);
  }
}
