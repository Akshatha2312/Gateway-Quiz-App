import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  // Subjects
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

  // Progress percentage for each subject
  final List<double> subjectProgress = const [80, 65, 70, 55, 60, 50, 75, 85, 40];

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Animation controller for bars
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Progress',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0077B6),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Your Progress Overview 📊',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0077B6),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subjects[index],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0077B6),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Animated horizontal bar
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Stack(
                              children: [
                                Container(
                                  height: 20,
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: screenWidth * (_animation.value * (subjectProgress[index] / 100)),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0077B6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${subjectProgress[index].toInt()}% completed',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
