import 'package:flutter/material.dart';
import 'package:movie_application/comingsoonpage/comingsoonpage.dart';
import 'package:movie_application/downloadpage/downloadpage.dart';
import 'package:movie_application/homepage/homepage.dart';
import 'package:movie_application/searchpage/searchpage.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentIndex = 0;
  Widget currentPage() {
    switch (currentIndex) {
      case 1:
        return const CommingSoonPage();
      case 2:
        return const SearchPage();
      case 3:
        return const DownloadPage();
      default:
        return const HomePage();
    }
  }

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              onTapped(value);
            },
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white30,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_outline_rounded),
                label: "Coming Soon",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.download),
                label: "Download",
              )
            ],
          ),
          body: currentPage(),
        ),
      ),
    );
  }
}