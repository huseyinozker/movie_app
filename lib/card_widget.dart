import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/class/movie.dart';
import 'package:movie_app/class/movieArguments.dart';
import 'package:movie_app/screens/movieScreen.dart';

class CardWidget extends StatefulWidget {
  final Movie movie;
  //const CardWidget({Key? key, this.description = "açıklama"}) : super(key: key);
  const CardWidget(this.movie);
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    var imgPath = widget.movie.poster_path;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7.5, 10, 7.5, 10),
        child: Container(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  Container(),
                  Image.network(
                    'https://www.themoviedb.org/t/p/w600_and_h900_bestv2$imgPath',
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(214, 114, 192, 255),
                        ),
                        child: Text(
                          widget.movie.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          MovieScreen.routeName,
          arguments: MovieArguments(
            widget.movie.id,
            widget.movie.name,
            widget.movie.overview,
            widget.movie.backdrop_path,
            widget.movie.poster_path,
          ),
        );
      },
    );
  }
}
/* 
Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  'https://www.themoviedb.org/t/p/w600_and_h900_bestv2$imgPath',
                ),
              ),
              /* Text(widget.movie.name) */
            ],
          )),
 */