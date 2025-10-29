import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'previousyearquestion.dart';
import 'syllabus.dart';
import 'attendquiz.dart';
import 'profile.dart';
import 'progress.dart';

class DashboardPage extends StatefulWidget {
  final String userName;

  const DashboardPage({
    super.key,
    required this.userName,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // ---------------- Dashboard Options (except Profile) ----------------
  final List<Map<String, dynamic>> options = [
    {
      "title": "📚 Previous Year Papers",
      "page": const PreviousYearQuestionPage(),
      "colors": <Color>[Color(0xFF0077b6), Color(0xFF00b4d8)],
    },
    {
      "title": "📝 Attend Quiz",
      "page": const AttendQuizPage(),
      "colors": <Color>[Color(0xFF0096c7), Color(0xFF48cae4)],
    },
    {
      "title": "📖 Syllabus",
      "page": const SyllabusPage(),
      "colors": <Color>[Color(0xFF0077b6), Color(0xFF00b4d8)],
    },
    {
      "title": "📊 Progress",
      "page": const ProgressPage(),
      "colors": <Color>[Color(0xFF0096c7), Color(0xFF48cae4)],
    },
  ];

  // ---------------- Profile Card ----------------
  final Map<String, dynamic> profileCard = {
    "title": "👤 Profile",
    "page": const ProfilePage(),
    "colors": <Color>[Color(0xFF0077b6), Color(0xFF00b4d8)],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // ---------------- Welcome Section ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Welcome, ${widget.userName} 🎉",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Your smart GATE CSE Companion 🚀",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ---------------- Dashboard Grid ----------------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: options.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      return _buildCard(
                        title: options[index]["title"] as String,
                        page: options[index]["page"] as Widget,
                        colors: options[index]["colors"] as List<Color>,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ---------------- Single Rectangular Profile Card ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildCard(
                  title: profileCard["title"] as String,
                  page: profileCard["page"] as Widget,
                  colors: profileCard["colors"] as List<Color>,
                  isRectangular: true, // rectangular shape
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Build Each Card ----------------
  Widget _buildCard({
    required String title,
    required Widget page,
    required List<Color> colors,
    bool isRectangular = false,
  }) {
    bool isHovering = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHovering = true),
          onExit: (_) => setState(() => isHovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: isHovering
                ? (Matrix4.identity()..scale(1.05))
                : Matrix4.identity(),
            height: isRectangular ? 70 : null,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(isRectangular ? 16 : 20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: isHovering ? 16 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(isRectangular ? 16 : 20),
                splashColor: Colors.white.withOpacity(0.2),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
