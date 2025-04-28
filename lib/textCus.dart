import 'package:flutter/material.dart';

class HelloText extends StatelessWidget {
  const HelloText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(text)));
  }
}
