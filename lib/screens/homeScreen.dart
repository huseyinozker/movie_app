import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/class/movie.dart';
import 'package:movie_app/class/movieList.dart';
import '../card_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<MovieList> fetchMovie() async {
  /* final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/550?api_key=618296b0d4de78eb022d87ef779c6ab0')); */
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/list/7102979?api_key=618296b0d4de78eb022d87ef779c6ab0'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var received = jsonDecode(response.body);
    var receivedItems = received["items"];
    print("yükleniyor");
    return MovieList.fromJson(received, receivedItems);
  } else {
    print("yüklenmiyor");
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = FirebaseFirestore.instance;
  late Future<MovieList> futureMovieList;

  List<Movie> movieList = [];

  @override
  void initState() {
    super.initState();
    futureMovieList = fetchMovie();
    print(futureMovieList);
    print("asdsa");
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference colRef = _firestore.collection('denemeCollection');
    print(colRef);
    var babaRef = colRef.doc('baba');
    print(babaRef);

    final firebaseUser = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Uygulama İsmi'),
      ),
      body: Center(
          child: Column(
        children: [
          /* ElevatedButton(
            child: Text("get data"),
            onPressed: () async {
              var response = await babaRef.get();
              print(response);
              dynamic map = response.data();
              print(map);
              print(map['isim']);
            },
          ), */
          FutureBuilder<MovieList>(
            future: futureMovieList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var items = snapshot.data!.items;
                return Flexible(
                    child: GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 1 / 1.5,
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardWidget(items[index]);
                  },
                ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return Text("yüklenmsedi");
              }

              // By default, show a loading spinner.
              //const CircularProgressIndicator();
            },
          ),
        ],
      )),
    );
  }
}
