import 'package:flutter/material.dart';
import 'package:movie_application/service/authservice.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            await auth.signOut();
          },
          child: const Text("Sign Out"),
        ),
      ),
    );
  }
}
