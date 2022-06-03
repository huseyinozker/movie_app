// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
/* Image.network('https://picsum.photos/250?image=1'),
              Image.network('https://picsum.photos/250?image=2'),
              Image.network('https://picsum.photos/250?image=3'),
              Image.network('https://picsum.photos/250?image=4'), */
// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/authentication_service.dart';
import 'package:movie_app/class/movie.dart';
import 'package:movie_app/class/movieList.dart';
import 'package:movie_app/screens/addSharingPage.dart';
import 'package:movie_app/screens/homeScreen.dart';
import 'package:movie_app/screens/loginScreen.dart';
import 'package:movie_app/screens/movieScreen.dart';
import 'package:movie_app/screens/profileScreen.dart';
import 'card_widget.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Welcome to Flutter',
        home: AuthenticationWrapper(), //HomeScreen(),
        routes: {
          MovieScreen.routeName: (context) => MovieScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          AddPage.routeName: (context) => AddPage()
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return HomeScreen();
    }
    return LoginHome();
  }
}
