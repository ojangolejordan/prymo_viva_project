
import 'package:admin/src/app/home/pages/video.page.dart';
import 'package:admin/src/app/users/pages/users.page.dart';
import 'package:admin/src/app/visuals/pages/visuals.page.dart';
import 'package:flutter/material.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  PageController? controller;
  int selectedIndex = 0;

  void changeIndex(int index) => setState(() {
        selectedIndex = index;
        controller!.jumpToPage(index);
      });

  @override
  void initState() {
    controller = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller, children: [
        UsersPage(),
        VideosPage(),
        VisualsPage(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.yellow,
        onTap: changeIndex,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            label: "Users",
            icon: Icon(Icons.account_box),
          ),
          BottomNavigationBarItem(
            label: "Videos",
            icon: Icon(Icons.video_camera_front),
          ),
          BottomNavigationBarItem(
            label: "Visuals",
            icon: Icon(Icons.remove_red_eye_rounded),
          ),
        ],
      ),
    );
  }
}
