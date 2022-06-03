import 'dart:ui';

import 'package:flutter/material.dart';

import '../class/movieArguments.dart';
import '../class/movieArguments.dart';

class MovieScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  const MovieScreen({Key? key}) : super(key: key);

  SliverAppBar showSliverAppBar(String screenTitle) {
    return SliverAppBar(
      backgroundColor: Colors.grey.shade50,
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: const TabBar(
        indicatorColor: Colors.blue,
        labelColor: Colors.blue,
        tabs: [
          Tab(
            icon: Icon(Icons.home),
            text: "Genel",
          ),
          Tab(
            icon: Icon(Icons.comment),
            text: "Yorumlar",
          ),
          /* Tab(
            icon: Icon(Icons.abc),
            text: "İncelemeler",
          ),
          Tab(
            icon: Icon(Icons.comment),
            text: "Yorumlar",
          ), */
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    MovieArguments args = MovieArguments(
      "name",
      "description",
      "backdrop_path",
      "poster_path",
    );
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as MovieArguments;
    }

    final backdropPath = args.backdrop_path;
    final posterPath = args.poster_path;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Container(
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                'https://www.themoviedb.org/t/p/original$backdropPath',
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        args.name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "2011 - devam ediyor..",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoItem(
                        "220",
                        "",
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InfoItem(
                        "587",
                        "",
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.black87,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InfoItem(
                        "8.7",
                        "2423",
                        Icon(
                          Icons.star,
                          color: Colors.orange[700],
                          size: 30,
                        ),
                      ),
                      Center(
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.lightBlue,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add_outlined),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TabBarView(
                    children: [
                      CustomScrollView(
                        slivers: [
                          showSliverAppBar("konu"),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Konu",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Text(
                                      args.description + args.description,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ),
                      CustomScrollView(
                        slivers: [
                          showSliverAppBar("konu"),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              const SizedBox(
                                height: 400,
                                child: Center(
                                  child: Text(
                                    'Home Tab',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1500,
                                color: Colors.green,
                              ),
                            ]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  InfoItem(this.text1, this.text2, this.icon);
  final String text1;
  final String text2;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 2.5,
        ),
        Text(
          text1,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        text2 != ""
            ? Text(
                "($text2)",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const Text(""),
      ],
    );
  }
}

/* 

Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.network(
                          'https://www.themoviedb.org/t/p/original$backdropPath'),
                    )
                  ],
                ),
                Positioned(
                  bottom: -100,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              'https://www.themoviedb.org/t/p/w600_and_h900_bestv2$posterPath'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        args.name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

 */
