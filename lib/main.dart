import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_application/screen/bookmarkpage/bookmarkpage.dart';
import 'package:movie_application/screen/homepage/homepage.dart';
import 'package:movie_application/service/authservice.dart';
import 'package:movie_application/screen/entry/authpage.dart';
import 'package:movie_application/screen/searchpage/searchpage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        return const SearchPage();
      case 2:
        return const BookmarkPage();
      case 3:
        return const AuthPage();
      default:
        return const HomePage();
    }
  }

  void onTapped(int index) {
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
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
                  icon: Icon(Icons.search),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: "Bookmarks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
            body: currentPage(),
          ),
        ),
      ),
    );
  }
}
