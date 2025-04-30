import 'package:component/button.dart';
import 'package:component/gender_select.dart';
import 'package:component/select_location.dart';

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
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectLocation(
            showChooseScreen: true,
            text: "Choose",
            borderRadius: BorderRadius.circular(10),
            locationList: [
              "Location 1",
              "Location 2",
              "Location 3",
              "Location 4",
            ],
          ),
        ),
      ),
    );
  }
}
