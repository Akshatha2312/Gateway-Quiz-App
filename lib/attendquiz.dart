import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'quizpage.dart';

class AttendQuizPage extends StatelessWidget {
  const AttendQuizPage({super.key});

  final List<String> subjects = const [
    "Digital Logic",
    "Computer Organization and Architecture",
    "Programming and Data Structures",
    "Algorithms",
    "Theory of Computation",
    "Compiler Design",
    "Operating System",
    "Databases",
    "Computer Networks",
  ];

  Future<List<dynamic>> loadQuestions(String subject) async {
    final String data = await rootBundle.loadString('assets/questions.json');
    final Map<String, dynamic> jsonData = json.decode(data);
    return jsonData[subject] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "📝 Attend Quiz",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0077b6),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white, // Set background to white
        child: ListView.separated(
          itemCount: subjects.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                final questions = await loadQuestions(subjects[index]);
                if (questions.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "No questions found for ${subjects[index]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFF0077b6),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(
                      subject: subjects[index],
                      questions: questions,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, // Card background white
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF0077b6), width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFcccccc),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Text(
                  subjects[index],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0077b6), // Text color blue
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
