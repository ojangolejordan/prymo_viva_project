import 'package:flutter/material.dart';
import 'package:prymo_mobile_app/app/src/home/pages/home.page.dart';
import 'package:prymo_mobile_app/app/src/library/pages/library.page.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> with AutomaticKeepAliveClientMixin{

@override
bool get wantKeepAlive => true;
  int selectedPage = 0;
  PageController? pageController;

  void changePage(int index) => setState(() {
        selectedPage = index;
        pageController!.jumpToPage(index);
      });

  @override
  void initState() {
    pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomePage(),
          LibraryPage()
        ],
        controller : pageController),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.yellow,
        backgroundColor: Colors.grey[900],
        currentIndex: selectedPage,
        onTap: changePage,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Visuals",
            icon: Icon(Icons.remove_red_eye),
          ),
        ],
      ),
    );
  }
}
