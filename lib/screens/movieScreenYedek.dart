import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/widgets/commentBox.dart';

import '../class/movieArguments.dart';
import '../class/movieArguments.dart';

class MovieScreen extends StatefulWidget {
  static const routeName = '/extractArguments';

  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();

    _controller = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        body: DefaultTabController(
      length: 4,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text(args.name),
          ),
          SliverToBoxAdapter(
            child: ClipRRect(
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
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
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
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
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
                ),
                const Divider(
                  thickness: 1.5,
                ),
              ],
            ),
          ),
          SliverAppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: Colors.grey[50],
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
                Tab(
                  icon: Icon(Icons.abc),
                  text: "İncelemeler",
                ),
                Tab(
                  icon: Icon(Icons.comment),
                  text: "Yorumlar",
                ),
              ],
            ),
          ),
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(
                      child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          children: const [
                            CommentBox(),
                            CommentBox(),
                            CommentBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          children: const [
                            CommentBox(),
                            CommentBox(),
                            CommentBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          children: const [
                            CommentBox(),
                            CommentBox(),
                            CommentBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                          children: const [
                            CommentBox(),
                            CommentBox(),
                            CommentBox(),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              )
              /* TabBarView(
                children: [
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
                          args.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      children: const [
                        CommentBox(),
                        CommentBox(),
                        CommentBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return const CommentBox();
                      },
                    ),
                  ),
                  const Center(
                    child: Icon(Icons.home),
                  ),
                ],
              ), */
              ),
        ],
      ),
    ));
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
