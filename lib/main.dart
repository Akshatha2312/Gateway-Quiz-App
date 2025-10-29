import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'register.dart';
import 'dashboard.dart'; // import DashboardPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Gateway',
      theme: ThemeData(
        primaryColor: const Color(0xFF0077b6),
        scaffoldBackgroundColor: Colors.white, // white background
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  bool _isHoveringLogin = false;
  bool _isHoveringRegister = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeInAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedButton({
    required String text,
    required VoidCallback onTap,
    required bool isHovering,
    required Function(bool) onHover,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isHovering ? const Color(0xFF0096c7) : const Color(0xFF0077b6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isHovering
              ? [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(0, 4),
              blurRadius: 8,
            )
          ]
              : [],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // white background
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Color(0xFF0077b6),
                    size: 70,
                  ),
                ),
                Text(
                  'Welcome to GATE CSE',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0077b6), // blue text
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  'Get started by logging in or registering',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: const Color(0xFF0077b6), // blue text
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                _buildAnimatedButton(
                  text: 'Login',
                  isHovering: _isHoveringLogin,
                  onHover: (hovering) {
                    setState(() {
                      _isHoveringLogin = hovering;
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildAnimatedButton(
                  text: '🆕 New User? Register here',
                  isHovering: _isHoveringRegister,
                  onHover: (hovering) {
                    setState(() {
                      _isHoveringRegister = hovering;
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
