import 'package:calculations/pages/mental_calc_settings.dart';
import 'package:calculations/variables/colors.dart';
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
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return MaterialApp(
      title: 'calculations',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            children: [
              Container(
                height: 100,
              ),

              // main body
              Expanded(
                child: getModeButtons(),
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

  Widget getModeButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            // columns---------------------------------
            return getButton(context, index);
          },
        ),
      ],
    );
  }

  Widget getButton(BuildContext buildContext, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 32.0,
      ),
      child: GestureDetector(
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            color: lightBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              pages[index].name,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                color: textColor,
              ),
            ),
          ),
        ),
        onTap: () {
          HapticFeedback.mediumImpact();

          Navigator.push(
            buildContext,
            MaterialPageRoute(
              builder: (context) {
                return pages[index].page;
              },
            ),
          );
        },
      ),
    );
  }
}

class Page {
  Widget page;
  String name;

  Page(this.page, this.name);
}
