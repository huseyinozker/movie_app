import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profilePage';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double coverHeight = 240;
  final double profileHeight = 128;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.grey[50],
                foregroundColor: Colors.black,
                pinned: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Hunter"),
                    CircleAvatar(
                      child: Text("H"),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    buildCoverImage(),
                    Positioned(
                      left: 10,
                      bottom: -128 / 2,
                      child: buildProfileImage(),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: SizedBox(
                    height: profileHeight * 1.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: profileHeight * 1,
                        ),
                        buildFollowButton()
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: buildInfo()),
              ),
            ];
          },
          body: Container(),
        ),
      ),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://www.themoviedb.org/t/p/original/6c9ovs2wuTZykm7Zk1q0dwkgnOj.jpg',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      );
  Widget buildProfileImage() => const CircleAvatar(
        radius: 128 / 2,
        child: Text("H"),
      );

  Widget buildInfo() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hunter",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Text(
            "@username",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
            style: TextStyle(fontSize: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [Icon(Icons.location_pin), Text("Ankara")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [Icon(Icons.link), Text("erozker.com")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.history),
              Text("11 Şub 2021 tarihinde katıldı")
            ],
          ),
          SizedBox(
            height: 32,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Wrap(
                  children: const [
                    Text("32", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "Alıntı",
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
                Wrap(
                  children: const [
                    Text("43", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "İnceleme",
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
                Wrap(
                  children: const [
                    Text("128", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "Yorum",
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
                Wrap(
                  children: const [
                    Text("32", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "Takipçi",
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
                Wrap(
                  children: const [
                    Text("32", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      "Takip Edilen",
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );
  Widget buildFollowButton() => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {},
        child: const Text(
          'Takip Et',
          style: TextStyle(color: Colors.white),
        ),
      );
}
/* 
Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(),
                      Positioned(
                        left: 10,
                        bottom: -((coverHeight - profileHeight) / 2),
                        child: buildProfileImage(),
                      )
                    ],
                  ), */