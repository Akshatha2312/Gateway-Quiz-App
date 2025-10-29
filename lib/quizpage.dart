import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'resultpage.dart';

class QuizPage extends StatefulWidget {
  final String subject;
  final List<dynamic> questions;

  const QuizPage({super.key, required this.subject, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  String? selectedAnswer;
  int correctCount = 0;
  int wrongCount = 0;
  int unansweredCount = 0;

  final List<String> optionLabels = ["A", "B", "C", "D"];

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return Scaffold(
        body: Center(child: Text("No questions available")),
      );
    }

    final question = widget.questions[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.subject, style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF0077b6),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question
            Text(
              "Q${currentIndex + 1}: ${question['question']}",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // Options
            ...List.generate(question['options'].length, (index) {
              final option = question['options'][index];

              return _QuizOption(
                label: optionLabels[index],
                text: option,
                isSelected: selectedAnswer == option,
                isCorrect: selectedAnswer == option
                    ? option == question['answer']
                    : null,
                onTap: () {
                  setState(() {
                    selectedAnswer = option;
                  });
                },
              );
            }),

            const SizedBox(height: 20),

            // Next Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0077b6),
                ),
                onPressed: () {
                  if (selectedAnswer == null) {
                    unansweredCount++;
                  } else if (selectedAnswer == question['answer']) {
                    correctCount++;
                  } else {
                    wrongCount++;
                  }

                  setState(() {
                    selectedAnswer = null;
                    if (currentIndex < widget.questions.length - 1) {
                      currentIndex++;
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResultPage(
                            total: widget.questions.length,
                            correct: correctCount,
                            wrong: wrongCount,
                            unanswered: unansweredCount,
                          ),
                        ),
                      );
                    }
                  });
                },
                child: Text("Next", style: GoogleFonts.poppins()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ Option Widget ------------------
class _QuizOption extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final bool? isCorrect; // null means not selected
  final VoidCallback onTap;

  const _QuizOption({
    required this.label,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    Color textColor = Colors.black;
    String emoji = "";

    if (isSelected && isCorrect != null) {
      if (isCorrect!) {
        bgColor = Colors.green;
        textColor = Colors.white;
        emoji = " ✅";
      } else {
        bgColor = Colors.red;
        textColor = Colors.white;
        emoji = " ❌";
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          foregroundColor: MaterialStateProperty.all(textColor),
          overlayColor: MaterialStateProperty.all(Colors.transparent), // No hover highlight
          padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFF0077b6)),
            ),
          ),
        ),
        onPressed: isSelected ? null : onTap, // Only allow tapping unselected options
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "$label. $text$emoji",
            style: GoogleFonts.poppins(fontSize: 16, color: textColor),
          ),
        ),
      ),
    );
  }
}
