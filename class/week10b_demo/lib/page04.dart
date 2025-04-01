import 'package:flutter/material.dart';

class Page04 extends StatefulWidget {
  const Page04({super.key});

  @override
  State<Page04> createState() => _Page04State();
}

class _Page04State extends State<Page04> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.green[50],
      child: Center(child: Text('Page 04')),
    );
  }
}
