import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/sqlDb.dart';
import 'Answer.dart';
import 'NotEnoughQuestions.dart';
import 'ResultSucsses.dart';
import 'ResultfailScreen.dart';

class StartQuiz extends StatefulWidget {
  @override
  _StartQuizState createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  int score = 0;
  int currentIndex = 0;
  int mark = 0;

  final SqlDb sqlDb = SqlDb();
  PageController pageController = PageController(initialPage: 0);
  String query = 'SELECT * FROM AddQuestions';
  Future<List<Map<String, dynamic>>> fetchData() async {
    return await sqlDb.readData(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data!.length >= 5) {
              return PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  var mid = snapshot.data.length / 2;

                  if (index == snapshot.data.length) {
                    Future.delayed(Duration(seconds: 1), () {
                      if (mark >= mid) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return ResultSucsses(
                            score: mark,
                            totalQuestions: snapshot.data.length,
                          );
                        }));
                      } else {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return ResultfailScreen(
                            score: mark,
                            totalQuestions: snapshot.data.length,
                          );
                        }));
                      }
                    });
                  } else {
                    //هاد ما الو لازم
                    // final currentQuestion = snapshot.data[index];
                    // final questionText = currentQuestion[SqlDb.COL_QUESTION_TEXT];
                    // final option1 = currentQuestion[SqlDb.COL_ANSWER_OPTIONS1];
                    // final option2 = currentQuestion[SqlDb.COL_ANSWER_OPTIONS2];
                    // final option3 = currentQuestion[SqlDb.COL_ANSWER_OPTIONS3];
                    // final option4 = currentQuestion[SqlDb.COL_ANSWER_OPTIONS4];
                    Map<String, dynamic> questionData = snapshot.data[index];
                    String question = questionData['Question'];
                    String firstAnswer = questionData['FirstAnswer'];
                    String secondAnswer = questionData['SecondAnswer'];
                    String thirdAnswer = questionData['ThirdAnswer'];
                    String fourthAnswer = questionData['FourthAnswer'];
                    String correctAnswer = questionData['CorrectAnswer'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Question ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.teal,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '/ ${snapshot.data.length}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal,
                            ),
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              question,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        //        Answer1( answer: firstAnswer, firstAnswer)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              onPressed: () {
                                if (correctAnswer == 'A') {
                                  setState(() {
                                    mark++;
                                  });
                                }
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                              child: Text(
                                firstAnswer,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              onPressed: () {
                                if (correctAnswer == 'B') {
                                  setState(() {
                                    mark++;
                                  });
                                }
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                              child: Text(
                                secondAnswer,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              onPressed: () {
                                if (correctAnswer == 'C') {
                                  setState(() {
                                    mark++;
                                  });
                                }
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                              child: Text(
                                thirdAnswer,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              onPressed: () {
                                if (correctAnswer == 'D') {
                                  setState(() {
                                    mark++;
                                  });
                                }
                                pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                              child: Text(
                                fourthAnswer,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            } else if (snapshot.hasData) {
              return NotEnoughQuestions();
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.teal),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Padding Answer1({String? answer, dynamic function}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 15),
          onPressed: function,
          child: Text(
            "$answer",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
