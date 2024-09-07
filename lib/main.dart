import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text(
        'Music Maestro',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue,
    ),
    body: Center(
      child: Stack(
        children: [
          // Position the image at the top
          Positioned(
            top: 0.0, // Set top position to 0
            left: 0.0, // Set left position to 0 (optional, for centering)
            right: 0.0, // Set right position to 0 (optional, for centering)
            child: Image.asset( // Replace with your image asset path
              'lib/music.png', // Adjust the image path
              fit: BoxFit.cover, // Adjust the image fit as needed
            ),
          ),
          // Position the Column containing the buttons
          Positioned(
            bottom: 100.0, // Set some space from bottom
            left: 0.0, // Optional, for centering
            right: 0.0, // Optional, for centering
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust spacing
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle button press here
                  },
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(height: 20), // Add space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Handle button press here
                  },
                  child: Text(
                    'Settings',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(height: 20), // Add space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Handle button press here
                  },
                  child: Text(
                    'Help',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
));