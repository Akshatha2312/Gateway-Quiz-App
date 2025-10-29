import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  final int total;
  final int correct;
  final int wrong;
  final int unanswered;

  const ResultPage({
    super.key,
    required this.total,
    required this.correct,
    required this.wrong,
    required this.unanswered,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Result", style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF0077b6),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFcccccc),
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Total Questions: $total", style: GoogleFonts.poppins(fontSize: 18)),
              const SizedBox(height: 10),
              Text("Correct Answers: $correct", style: GoogleFonts.poppins(fontSize: 18, color: Colors.green)),
              const SizedBox(height: 10),
              Text("Wrong Answers: $wrong", style: GoogleFonts.poppins(fontSize: 18, color: Colors.red)),
              const SizedBox(height: 10),
              Text("Unanswered: $unanswered", style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0077b6)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back to Subjects", style: GoogleFonts.poppins()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
