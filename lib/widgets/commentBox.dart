import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/class/movie.dart';
import 'package:movie_app/class/movieArguments.dart';
import 'package:movie_app/screens/movieScreen.dart';
import 'package:movie_app/screens/profileScreen.dart';

class CommentBox extends StatefulWidget {
  //const CommentBox({Key? key, this.description = "açıklama"}) : super(key: key);
  const CommentBox();
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
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: const Text('H'),
                  ),
                  Text(
                    "Hüseyin",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "@hunter",
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
              children: const [
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  style: TextStyle(height: 1.5),
                )
              ],
            )
          ]),
        ));
  }
}
