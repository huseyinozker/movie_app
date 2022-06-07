import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/class/movie.dart';
import 'package:movie_app/class/movieArguments.dart';
import 'package:movie_app/screens/movieScreen.dart';
import 'package:movie_app/screens/profileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentBox extends StatefulWidget {
  //const CommentBox({Key? key, this.description = "açıklama"}) : super(key: key);
  final QueryDocumentSnapshot comment;
  const CommentBox(this.comment);
  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey[50],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('H'),
                  ),
                  Text(
                    widget.comment['user_name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "@${widget.comment['user_nick']}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProfileScreen.routeName,
                );
              },
            ),
            Column(
              children: [
                Text(
                  widget.comment['comment'],
                  style: const TextStyle(height: 1.5),
                )
              ],
            )
          ]),
        ));
  }
}
