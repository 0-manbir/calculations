import "package:calculations/variables/colors.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class Doubles extends StatefulWidget {
  final int number;

  const Doubles({super.key, required this.number});

  @override
  // ignore: no_logic_in_create_state
  State<Doubles> createState() => _DoublesState(number);
}

class _DoublesState extends State<Doubles> {
  late int startNumber, startNumberReplay;
  bool gameFinished = false;
  int correctAnswers = 0;

  TextEditingController answerText = TextEditingController();

  _DoublesState(int number) {
    startNumber = number;
  }

  @override
  Widget build(BuildContext context) {
    // variables
    double statusBarHeight = MediaQuery.of(context).padding.top;
    startNumberReplay = startNumber;

    return GestureDetector(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Center(
            child: childSelector(context),
          ),
        ),
      ),
      onTap: () {
        HapticFeedback.heavyImpact();
      },
    );
  }

  Widget childSelector(BuildContext buildContext) {
    if (gameFinished) {
      return gameFinishWidget(buildContext);
    } else {
      return gameWidget(buildContext);
    }
  }

  Widget gameWidget(BuildContext buildContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$startNumber",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 78,
            color: Colors.grey[600],
            height: 1.0,
          ),
        ),
        Container(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 8.0),
          child: TextField(
            autofocus: true,
            controller: answerText,
            maxLines: 1,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            cursorColor: Colors.grey[500],
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.grey[700],
              fontSize: 26,
            ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: "answer...",
              labelStyle: TextStyle(
                fontFamily: 'Inter',
                color: Colors.grey[300],
                fontSize: 28,
              ),
            ),
            onChanged: (value) {
              if (value.length == startNumber.toString().length) {
                HapticFeedback.mediumImpact();
                changeNumber();
                answerText.text = "";
              }
            },
          ),
        ),
      ],
    );
  }

  Widget gameFinishWidget(BuildContext buildContext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "You entered ${answerText.text}",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 36,
            color: Colors.grey[400],
          ),
        ),
        Container(height: 24),
        Text(
          "The correct answer was $startNumber}",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 36,
            color: Colors.grey[400],
          ),
        ),
        Container(height: 24),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "replay",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),
          onTap: () {
            HapticFeedback.heavyImpact();

            Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Doubles(number: startNumberReplay);
                },
              ),
            );
          },
        ),
        Container(height: 15),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "back",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void changeNumber() {
    if (startNumber * 2 == int.parse(answerText.text)) {
      setState(() {
        startNumber *= 2;
        correctAnswers++;
      });
    } else {
      setState(() {
        gameFinished = false;
      });
    }
  }
}
