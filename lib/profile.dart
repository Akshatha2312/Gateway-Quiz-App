import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart'; // Import your main.dart (make sure it has HomePage or initial page)

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String year = "";
  String dob = "";
  String email = "";
  String regNo = "";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('username') ?? "";
      year = prefs.getString('year') ?? "";
      dob = prefs.getString('dob') ?? "";
      email = prefs.getString('email') ?? "";
      regNo = prefs.getString('regno') ?? "";
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved data

    if (!mounted) return;
    // Navigate to HomePage from main.dart after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()), // Replace MyApp() with your main page if different
          (route) => false, // Remove all previous routes
    );
  }

  Widget buildProfileItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFcccccc),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text("$label: ",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0077b6),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: _logout,
          )
        ],
      ),
      body: name.isEmpty
          ? Center(
        child: Text(
          "No profile data found. Please register first.",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFF0077b6),
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : "",
                style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Name Card
            Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Student",
              style: GoogleFonts.poppins(
                  fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            // Profile Details
            buildProfileItem("Year", year),
            buildProfileItem("DOB", dob),
            buildProfileItem("Email", email),
          ],
        ),
      ),
    );
  }
}
