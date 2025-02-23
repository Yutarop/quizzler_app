import 'package:flutter/material.dart';
// import 'dart:math';
// import 'question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Quiz_brain quiz_brain = Quiz_brain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userAnswer){
    if (quiz_brain.canContinue() == true) {
      bool correctAnswer = quiz_brain.getQuestionAnswer();
      if (correctAnswer == userAnswer) {
        setState(() {
          scoreKeeper.add(
              Icon (
                Icons.check,
                color: Colors.green,
              )
          );
        });
      } else {
        setState(() {
          scoreKeeper.add(
              Icon (
                Icons.close,
                color: Colors.red,
              )
          );
        });
      }
      setState(() {
        bool alertEx = quiz_brain.nextQuestion();
        if (!alertEx){
          alert();
        }
      });
    }
  }

  void alert() {
    setState(() {
      Alert(
        context: context,
        type: AlertType.error,
        title: "FNISHED",
        desc: "You've reached the end of the quiz.",
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                scoreKeeper = [];
              });
            },
            width: 120,
          )
        ],
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz_brain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
            decoration: BoxDecoration(
              color: Colors.green
            ),
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              }
            )
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
            decoration: BoxDecoration(
              color: Colors.red
            ),
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
