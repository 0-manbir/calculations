import "dart:math";

import "package:calculations/pages/doubles.dart";
import "package:calculations/variables/colors.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class DoublesSettings extends StatefulWidget {
  const DoublesSettings({super.key});

  @override
  State<DoublesSettings> createState() => _DoublesSettingsState();
}

class _DoublesSettingsState extends State<DoublesSettings> {
  TextEditingController inputNumberController = TextEditingController();

  TextEditingController minNumberController = TextEditingController();
  TextEditingController maxNumberController = TextEditingController();

  // number to start from (to calculate doubles)
  late int number;

  @override
  Widget build(BuildContext context) {
    // variables
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: screenHeight - statusBarHeight,
            width: screenWidth,
            child: Column(
              children: [
                // back button----------------------------------------------------------------------
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 22,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(
                                  width: 4, height: double.minPositive),
                              Text(
                                "back",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          // back button pressed
                          HapticFeedback.mediumImpact();
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // input for a number
                        SizedBox(
                          width: screenWidth * 0.75,
                          child: TextField(
                            controller: inputNumberController,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.grey[500],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.grey[600],
                              fontSize: 22,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              counterText: "",
                              border: InputBorder.none,
                              hintText: "enter a number...",
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.grey[300],
                                fontSize: 24,
                              ),
                            ),
                            onSubmitted: (value) {
                              if (value.trim() == "") return;
                              number = int.parse(value);
                              start();
                            },
                          ),
                        ),

                        Container(height: 42),

                        Text(
                          "-or-",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            color: Colors.grey[300],
                          ),
                        ),

                        Container(height: 42),

                        // random number
                        Container(
                          width: screenWidth * 0.75,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: minNumberController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: Colors.grey[500],
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: "from...",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.grey[300],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Container(width: 15),
                              Expanded(
                                child: TextField(
                                  controller: maxNumberController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: Colors.grey[500],
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: "to...",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.grey[300],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),

                              // random number button
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 12.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Icon(
                                    Icons.refresh_rounded,
                                    color: Colors.grey[100],
                                  ),
                                ),
                                onTap: () {
                                  HapticFeedback.mediumImpact();

                                  int min = int.parse(minNumberController.text);
                                  int max = int.parse(maxNumberController.text);

                                  number =
                                      Random().nextInt(max - min + 1) + min;

                                  start();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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

  void start() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Doubles(number: number);
        },
      ),
    );
  }
}
