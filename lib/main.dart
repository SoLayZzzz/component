import 'package:component/schedule_list.dart';
import 'package:component/select_date.dart';
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
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectDate(
                onSeclectDate: (formarttDate) {
                  setState(() {
                    selectedDate = formarttDate;
                  });
                  print("Selected date: $formarttDate");
                },
              ),
            ),
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _postDate();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _postDate() {
    if (selectedDate != null) {
      print("Posting date ===>> $selectedDate");
    } else {
      print("No date selected yet.");
    }
  }
}
