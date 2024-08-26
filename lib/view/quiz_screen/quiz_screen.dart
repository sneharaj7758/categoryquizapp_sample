import 'package:categoryquizapp_sample/colorconstants.dart';
import 'package:categoryquizapp_sample/view/resultpage.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class QuizScreen extends StatefulWidget {
  final Map<String, dynamic> categoryData;

  QuizScreen({required this.categoryData});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int selectedOptionIndex = -1;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int skippedAnswers = 0;
  bool hasAnswered = false;

  final CountDownController _controller = CountDownController();
  final int _duration = 30;

  late Map<String, dynamic> currentQuestion;

  @override
  void initState() {
    super.initState();
    currentQuestion = widget.categoryData['questions'][currentQuestionIndex];
  }

  void checkAnswer(int selectedOptionIndex) {
    setState(() {
      if (selectedOptionIndex == currentQuestion['answer']) {
        correctAnswers++;
      } else {
        wrongAnswers++;
      }

      this.selectedOptionIndex = selectedOptionIndex;

      hasAnswered = true;

      _controller.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = widget.categoryData['questions'];

    return Scaffold(
      backgroundColor: Colorconstants.BG_COLOR,
      appBar: AppBar(
        backgroundColor: Colorconstants.BG_COLOR,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              widget.categoryData['category'],
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Text(
              "${currentQuestionIndex + 1}/${widget.categoryData['totalQuestions']}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colorconstants.CONTAINER_BG,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '${currentQuestion['question']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 160,
                    child: CircularCountDownTimer(
                      duration: _duration,
                      controller: _controller,
                      width: 30,
                      height: 30,
                      ringColor: Colors.grey[300]!,
                      fillColor: Colors.blue.shade800,
                      strokeWidth: 4.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      isReverse: true,
                      isReverseAnimation: true,
                      isTimerTextShown: true,
                      autoStart: true,
                      onComplete: () {
                        if (!hasAnswered) {
                          skippedAnswers++;
                        }
                        if (currentQuestionIndex <
                            widget.categoryData['questions'].length - 1) {
                          setState(() {
                            currentQuestionIndex++;
                            selectedOptionIndex = -1;
                            currentQuestion = widget.categoryData['questions']
                                [currentQuestionIndex];
                            hasAnswered = false;
                            _controller.restart(duration: _duration);
                          });
                        } else {
                          _controller.pause();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultsPage(
                                correctAnswers: correctAnswers,
                                wrongAnswers: wrongAnswers,
                                skippedAnswers: skippedAnswers,
                                totalQuestions:
                                    widget.categoryData['totalQuestions'],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  for (int i = 0; i < currentQuestion['options'].length; i++)
                    GestureDetector(
                      onTap: hasAnswered
                          ? null
                          : () =>
                              checkAnswer(i), 
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: hasAnswered &&
                                      i == currentQuestion['answer']
                                  ? Colors.green 
                                  : (selectedOptionIndex == i
                                      ? Colors.red 
                                      : Colorconstants.CONTAINER_BG),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentQuestion['options'][i],
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  hasAnswered && i == currentQuestion['answer']
                                      ? Icons.check_circle
                                      : (selectedOptionIndex == i
                                          ? Icons.cancel
                                          : Icons.radio_button_unchecked),
                                  color: hasAnswered &&
                                          i == currentQuestion['answer']
                                      ? Colors.green
                                      : (selectedOptionIndex == i
                                          ? Colors.red
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  if (!hasAnswered) {
                    skippedAnswers++;
                  }
                  if (currentQuestionIndex < questions.length - 1) {
                    setState(() {
                      currentQuestionIndex++;
                      selectedOptionIndex = -1;
                      currentQuestion = questions[currentQuestionIndex];
                      hasAnswered = false;
                      _controller.restart(duration: _duration);
                    });
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsPage(
                          correctAnswers: correctAnswers,
                          wrongAnswers: wrongAnswers,
                          skippedAnswers: skippedAnswers,
                          totalQuestions: widget.categoryData['totalQuestions'],
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    currentQuestionIndex < questions.length - 1
                        ? "Next"
                        : "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
