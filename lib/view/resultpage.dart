import 'package:categoryquizapp_sample/colorconstants.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedAnswers;

  ResultsPage({
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedAnswers,
    required totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.BG_COLOR,
      appBar: AppBar(
          backgroundColor: Colorconstants.BG_COLOR,
          title: Text("Quiz Results", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Correct Answers: $correctAnswers",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            Text(
              "Wrong Answers: $wrongAnswers",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            Text(
              "Skipped Answers: $skippedAnswers",
              style: TextStyle(fontSize: 20, color: Colors.yellow),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the start
              },
              child: Text("Restart Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}
