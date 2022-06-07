import 'package:flutter/material.dart';
import 'package:movie_app/class/movieArguments.dart';
import 'dart:ui';

import 'package:movie_app/services/CommentService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatefulWidget {
  static const routeName = '/addPage';

  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController statusController = TextEditingController();
  String dropdownvalue = 'Alıntı';

  CommentService _commentService = CommentService();
  // List of items in our dropdown menu
  var dropItems = [
    'Alıntı',
    'Yorum',
    'İnceleme',
  ];
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference colRef = _firestore.collection('UsersCollection');
    var userRef = colRef.doc("${auth.currentUser?.uid}");
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

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Ekle"),
        ),
        body: Column(
          /* mainAxisAlignment: MainAxisAlignment.spaceBetween, */
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  // Initial Value
                  value: dropdownvalue,
                  isExpanded: true,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: dropItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Container(
                height: size.height * .4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextField(
                          controller: statusController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            hintText: "Bir şeyler yazın...",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 25),
              child: InkWell(
                onTap: () async {
                  if (statusController.text != "") {
                    var userResponse = await userRef.get();
                    dynamic userMap = userResponse.data();

                    _commentService
                        .addComment(
                            dropdownvalue,
                            "${auth.currentUser?.uid}",
                            userMap["name"],
                            userMap["nickname"],
                            args.id,
                            statusController.text,
                            0)
                        .then((value) => showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Icon(Icons.bookmark_added_rounded),
                                content: Text("Başarıyla Eklendi"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Tamam"),
                                  ),
                                ],
                              ),
                            ));
                  } else {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Icon(Icons.warning),
                        content: Text("Lütfen bir şeyler yazın"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: const Text("Tamam"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      //color: colorPrimaryShade,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                        child: Text(
                      "Ekle",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
