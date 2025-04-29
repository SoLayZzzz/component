import 'package:component/gender_select.dart';
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

  int selectedGender = 0;
  int male = 1;
  int female = 2;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void _onGenderTap(int genderValue) {
      setState(() {
        widget.selectedGender = genderValue;
        print("====>> value :  ${widget.selectedGender = genderValue}");
      });
    }

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenderSelectOption(
              icon: Icons.male,
              value: widget.male,
              label: 'Male',
              groupValue: widget.selectedGender,
              onTap: () => _onGenderTap(widget.male),
            ),

            SizedBox(width: 20),

            GenderSelectOption(
              value: widget.female,
              icon: Icons.female,
              label: 'female',
              groupValue: widget.selectedGender,
              onTap: () => _onGenderTap(widget.female),
            ),
          ],
        ),
      ),
    );
  }
}
