import 'package:flutter/material.dart';
import 'answer.dart';
import 'question.dart';
import 'score.dart';

class Quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuizState();
}

class QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  int score = 0;

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  final quiz = [
    {
      'question': 'Q 1 - Which of the following is correct about Java 8 lambda expression ?',
      'answers': [
        {
          'answer': 'A - Using lambda expression, you can refer to final variable or effectively final variable (which is assigned only once)',
          'correct': false
        },
        {
          'answer': 'B - Lambda expression throws a compilation error, if a variable is assigned a value the second time ?',
          'correct': false
        },
        {'answer': 'C - Both of the above.', 'correct': true},
        {'answer': 'D - None of the above.', 'correct': false},
      ],
    },
    {
      'question': 'Q 8 - Which of the following is the correct lambda expression which add two numbers and return their sum?',
      'answers': [
        {'answer': 'A - (int a, int b) -> { return a + b;};', 'correct': false},
        {'answer': 'B - (a, b) -> {return a + b;};', 'correct': false},
        {'answer': 'C - Both of the above.', 'correct': true},
        {'answer': 'D - None of the above.', 'correct': false},
      ],
    }
  ];

  void answerQuestion(bool correct) {
    if (correct) score++;

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex < quiz.length) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade100,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / quiz.length,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple.shade600),
                  minHeight: 8,
                ),
              ),

              // Question counter
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Question ${currentQuestionIndex + 1} of ${quiz.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 20),

              // Question container with styling
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.shade200,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Question(quiz[currentQuestionIndex]['question'] as String),
              ),

              SizedBox(height: 24),

              // Answers with improved styling
              Expanded(
                child: ListView.builder(
                  itemCount: (quiz[currentQuestionIndex]['answers'] as List).length,
                  itemBuilder: (context, index) {
                    final answer = (quiz[currentQuestionIndex]['answers'] as List<Map<String, Object>>)[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white,
                            Colors.blue.shade50,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Answer(
                            () => answerQuestion(answer['correct'] == true),
                        answer['answer'] as String,
                      ),
                    );
                  },
                ),
              ),

              // Score display
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.shade300,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Score:',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$score',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade100,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: Score(score, resetQuiz, quiz.length),
      );
    }
  }
}