import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int originalBpm;
  final double userBpm;

  ResultScreen({required this.originalBpm, required this.userBpm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BPM Result"),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Original BPM: $originalBpm",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              "Your BPM: ${userBpm.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              userBpm > originalBpm + 5
                  ? "You were too fast!"
                  : userBpm < originalBpm - 5
                      ? "You were too slow!"
                      : "Great job! You matched the BPM well!",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true); // Return to the game and allow retry
              },
              child: Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
