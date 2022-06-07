import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/screens/addSharingPage.dart';
import 'package:movie_app/widgets/commentBox.dart';

import '../class/movieArguments.dart';
import '../class/movieArguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieScreen extends StatefulWidget {
  static const routeName = '/extractArguments';

  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with SingleTickerProviderStateMixin {
  final _firestore = FirebaseFirestore.instance;
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
    final List<String> tabs = <String>['Comment', 'Quotes', 'Review'];
    MovieArguments args = MovieArguments(
      -1,
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
    print(args.id);
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddPage.routeName,
                arguments: args,
              );
            },
            child: const Icon(Icons.add),
          ),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverSafeArea(
                      top: false,
                      bottom: false,
                      sliver: SliverAppBar(
                        pinned: true,
                        title: Text(args.name),
                      ),
                    ),
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
                ];
              },
              body: Padding(
                padding: EdgeInsets.all(0),
              ) /* TabBarView(children: [
              Expanded(
                child: Container(
                  color: Colors.blueGrey[50],
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      args.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              ...tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context1) {
                      return StreamBuilder(
                        stream: _firestore
                            .collection(name)
                            .where('movie_id', isEqualTo: args.id)
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data != null) {
                            return CustomScrollView(
                              key: PageStorageKey<String>(name),
                              slivers: [
                                SliverOverlapInjector(
                                  handle: NestedScrollView
                                      .sliverOverlapAbsorberHandleFor(context1),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return Card(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          child: CommentBox(snapshot
                                              .data.docs[index]) //CommentBox(),
                                          );
                                    },
                                    childCount: snapshot
                                        .data.docs.length, // 1000 list items
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text("data");
                          }
                        },
                      );
                      /* return CustomScrollView(
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          StreamBuilder(
                            stream: _firestore
                                .collection("Comment")
                                .where('movie_id', isEqualTo: args.id)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return const Card(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: CommentBox(),
                                    );
                                  },
                                  childCount: snapshot
                                      .data.docs.length, // 1000 list items
                                ),
                              );
                            },
                          )
                        ],
                      ); */
                    },
                  ),
                );
              }).toList(),
            ]), */
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
