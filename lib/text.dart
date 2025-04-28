import 'package:flutter/material.dart';

class CustomerText extends StatelessWidget {
  const CustomerText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(text)));
  }
}
