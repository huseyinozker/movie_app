import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/model/comment.dart';
import 'package:movie_app/model/quote.dart';

class QuoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Quote> addQuote(
    String user_id,
    String user_name,
    String user_nick,
    int movie_id,
    String quote,
    int like_count,
  ) async {
    var _qRef = _firestore.collection("Quote");

    like_count = 0;

    var documentRef = await _qRef.add({
      "user_id": user_id,
      "user_name": user_name,
      "user_nick": user_nick,
      "quote": quote,
      "movie_id": movie_id,
      "like_count": like_count
    });

    return Quote(
        id: documentRef.id,
        user_id: user_id,
        user_name: user_name,
        user_nick: user_nick,
        movie_id: movie_id,
        quote: quote,
        like_count: like_count);
  }
}
