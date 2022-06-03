import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/model/comment.dart';

class CommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Comment> addComment(
    String user_id,
    int movie_id,
    String comment,
    int like_count,
  ) async {
    var _ref = _firestore.collection("Comment");

    like_count = 0;

    var documentRef = await _ref.add({
      "user_id": user_id,
      "comment": comment,
      "movie_id": movie_id,
      "like_count": like_count
    });

    return Comment(
        id: documentRef.id,
        user_id: user_id,
        movie_id: movie_id,
        comment: comment,
        like_count: like_count);
  }
}
