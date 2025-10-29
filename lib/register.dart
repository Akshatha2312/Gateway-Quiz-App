import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'dashboard.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  bool _obscurePassword = true;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isHoveringRegister = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    yearController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text.trim());
    await prefs.setString('email', emailController.text.trim());
    await prefs.setString('password', passwordController.text.trim());
    await prefs.setString('dob', dobController.text.trim());
    await prefs.setString('year', yearController.text.trim());
  }

  void registerUser() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        dobController.text.isEmpty ||
        yearController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    await _saveUserData();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registered successfully")),
    );

    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? 'User';

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardPage(userName: username),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isPassword,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? _obscurePassword : false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF0077b6)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF0077b6),
          ),
          onPressed: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        )
            : null,
      ),
    );
  }

  Widget _buildAnimatedButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHoveringRegister = true),
      onExit: (_) => setState(() => _isHoveringRegister = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
          _isHoveringRegister ? const Color(0xFF0096c7) : const Color(0xFF0077b6),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: registerUser,
          child: Text(
            "Register",
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
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add, size: 80, color: const Color(0xFF0077b6)),
                const SizedBox(height: 20),
                Text(
                  "Create your account",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0077b6),
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField("Username", usernameController, false),
                const SizedBox(height: 15),
                _buildTextField("Email", emailController, false,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 15),
                _buildTextField("Password", passwordController, true),
                const SizedBox(height: 15),
                TextField(
                  controller: dobController,
                  readOnly: true,
                  onTap: _pickDate,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    labelStyle: const TextStyle(color: Color(0xFF0077b6)),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: const Icon(Icons.calendar_today,
                        color: Color(0xFF0077b6)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 15),
                _buildTextField("Year", yearController, false),
                const SizedBox(height: 30),
                _buildAnimatedButton(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0077b6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
