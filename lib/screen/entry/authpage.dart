import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_application/screen/entry/entrypage.dart';
import 'package:movie_application/screen/profilepage/profilepage.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    if (user == null) {
      return const EntryPage();
    } else {
      return const ProfilePage();
    }
  }
}
