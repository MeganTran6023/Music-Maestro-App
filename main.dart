import 'package:flutter/material.dart';
import 'instructions.dart'; // Import the instructions page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musician Aptitude Game',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(), // HomePage will navigate to InstructionsPage
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This will navigate to the InstructionsPage
  void _goToInstructions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InstructionsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: GestureDetector(
        onTap: _goToInstructions, // Change this to go to instructions
        child: Center(
          child: Text(
            'Tap to Play',
            style: TextStyle(fontSize: 48, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
