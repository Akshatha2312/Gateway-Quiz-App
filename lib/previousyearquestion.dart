import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviousYearQuestionPage extends StatelessWidget {
  const PreviousYearQuestionPage({super.key});

  // Year-wise question papers with sets
  final Map<String, List<Map<String, String>>> yearPapers = const {
    "2025": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2025/03/CS-GATE-2025_Paper-I-Final-with-Keys.pdf"
      }
    ],
    "2024": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2024/02/CS-GATE-2024_Paper-I-Final.pdf"
      },
      {
        "title": "Set 2",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2024/02/CS-GATE-2024-Paper-II_Final.pdf"
      }
    ],
    "2023": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2023/04/CS-GATE-2023_Final.pdf"
      }
    ],
    "2022": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2022/10/CS-GATE-2022-Final.pdf"
      }
    ],
    "2021": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2023/01/CS-Gate-2021-Set-1.pdf"
      },
      {
        "title": "Set 2",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/CS-Gate-2021-Paper-2.pdf"
      }
    ],
    "2020": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/CS-Gate-2020.pdf"
      }
    ],
    "2019": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/CS-Gate-2019.pdf"
      }
    ],
    "2018": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2018.pdf"
      }
    ],
    "2017": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2017-Set-1.pdf"
      },
      {
        "title": "Set 2",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2017-Set-2.pdf"
      }
    ],
    "2016": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2016-Set-1.pdf"
      },
      {
        "title": "Set 2",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2016-Set-2.pdf"
      }
    ],
    "2015": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2015-Set-1.pdf"
      },
      {
        "title": "Set 2",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2015-Set-2.pdf"
      },
      {
        "title": "Set 3",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2015-Set-3.pdf"
      }
    ],
    "2014": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2014-Set-1.pdf"
      },
      {
        "title": "Set 2",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2014-Set-2.pdf"
      },
      {
        "title": "Set 3",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2014-Set-3.pdf"
      },
      {
        "title": "Set 4",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2014-Set-4.pdf"
      }
    ],
    "2013": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/EC-GATE-2013.pdf"
      }
    ],
    "2012": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/CS-Gate-2012.pdf"
      }
    ],
    "2011": [
      {
        "title": "Set 1",
        "url":
        "https://gateforumonline.com/wp-content/uploads/2021/09/CS-Gate-2011.pdf"
      }
    ],
  };

  // Function to launch external URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Flatten year + set list for GridView
    final List<Map<String, String>> flatList = [];
    yearPapers.forEach((year, sets) {
      for (var paper in sets) {
        flatList.add({
          "year": year,
          "title": paper["title"]!,
          "url": paper["url"]!,
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.white, // ✅ Set background to white
      appBar: AppBar(
        title: Text(
          "📚 Previous Year Papers",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0077B6), // deep blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: flatList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = flatList[index];
            return InkWell(
              onTap: () => _launchURL(item["url"]!),
              borderRadius: BorderRadius.circular(100),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0096C7), // medium blue
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "${item["year"]}\n${item["title"]}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
