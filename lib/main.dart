import 'package:component/button.dart';
import 'package:component/gender_select.dart';
import 'package:component/text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.select = true});

  bool select;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenderSelectOption(
              icon: Icons.male,
              label: 'Male',
              selected: widget.select,
              onTap: () => setState(() => widget.select = true),
              // selectColor: Colors.blue,
              // unselectColor: Colors.grey[200]!,
              // selectTextColor: Colors.white,
              // unselectTextColor: Colors.black,
              // iconSize: 20,
              // fontSize: 20,
              // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),

            SizedBox(width: 20),

            GenderSelectOption(
              icon: Icons.female,
              label: 'female',
              selected: !widget.select,
              onTap: () => setState(() => widget.select = false),
              // selectColor: Colors.blue,
              // unselectColor: Colors.grey[200]!,
              // iconSize: 20,
              // fontSize: 20,
              // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ],
        ),
      ),
    );
  }
}
