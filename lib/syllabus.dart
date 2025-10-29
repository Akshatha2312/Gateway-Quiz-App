import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';

class SyllabusPage extends StatefulWidget {
  const SyllabusPage({super.key});

  @override
  _SyllabusPageState createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  String? pdfPath;
  int pages = 0;
  int currentPage = 0;
  PDFViewController? pdfViewController;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  // Load PDF from assets and copy to app's local storage
  Future<void> loadPDF() async {
    final data = await rootBundle.load('assets/syllabus.pdf');
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/syllabus.pdf");
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);

    setState(() {
      pdfPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Light cyan background
      appBar: AppBar(
        title: Text(
          "📖 Syllabus",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0077b6), // Deep blue
        centerTitle: true,
        actions: [
          if (pages > 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  "${currentPage + 1} / $pages",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: pdfPath == null
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF0077b6), // Deep blue spinner
        ),
      )
          : PDFView(
        filePath: pdfPath!,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onRender: (totalPages) {
          setState(() {
            pages = totalPages ?? 0;
          });
        },
        onViewCreated: (controller) {
          pdfViewController = controller;
        },
        onPageChanged: (page, total) {
          setState(() {
            currentPage = page ?? 0;
          });
        },
      ),
    );
  }
}
