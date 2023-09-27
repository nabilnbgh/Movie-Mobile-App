import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommingSoonPage extends StatefulWidget {
  const CommingSoonPage({super.key});

  @override
  State<CommingSoonPage> createState() => _CommingSoonPageState();
}

class _CommingSoonPageState extends State<CommingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "Comming Soon Page",
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
