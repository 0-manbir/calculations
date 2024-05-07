import 'package:calculations/pages/mental_calc_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // pages
  final List<Page> pages = [
    Page(const MentalCalculationSettings(), 'mental calculator'),
  ];

  @override
  Widget build(BuildContext context) {
    // variables
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return MaterialApp(
      title: 'calculations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            children: [
              // icons, etc
              Container(
                height: 100,
              ),

              // main body
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        // columns---------------------------------
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 32.0,
                          ),
                          child: GestureDetector(
                            child: Container(
                              height: 75,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  pages[index].name,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 24,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              HapticFeedback.mediumImpact();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return pages[index].page;
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // footer
              Container(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page {
  Widget page;
  String name;

  Page(this.page, this.name);
}
