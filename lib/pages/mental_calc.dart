import 'dart:async';
import 'dart:math';

import 'package:calculations/variables/colors.dart';
import 'package:calculations/variables/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentalCalculation extends StatefulWidget {
  final MentalCalculationData mentalCalculationData;

  const MentalCalculation({super.key, required this.mentalCalculationData});

  @override
  State<MentalCalculation> createState() =>
      // ignore: no_logic_in_create_state
      _MentalCalculationState(mentalCalculationData);
}

class _MentalCalculationState extends State<MentalCalculation> {
  late MentalCalculationData data;
  int currentIndex = 0;
  String currentOperator = "";
  String currentOperand = "";
  bool result = false;

  double answer = 0.0;

  final TextEditingController resultController = TextEditingController();

  GameState gameState = GameState.playing;

  _MentalCalculationState(MentalCalculationData mentalCalculationData) {
    data = mentalCalculationData;
  }

  @override
  void initState() {
    startTimer(data.autoTimer);
    updateCalculation();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // variables
    double statusBarHeight = MediaQuery.of(context).padding.top;

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
        if (gameState == GameState.playing) {
          HapticFeedback.heavyImpact();
          updateCalculation();
        }
      },
    );
  }

  // other widgets

  Widget childSelector(BuildContext buildContext) {
    switch (gameState) {
      case GameState.playing:
        return playWidget(buildContext);
      case GameState.input:
        return inputWidget(buildContext);
      case GameState.result:
        return resultWidget(buildContext);
    }
  }

  Widget playWidget(BuildContext buildContext) {
    double screenWidth = MediaQuery.of(buildContext).size.width;
    return Row(
      children: [
        Center(
          child: Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Text(
                "$currentIndex / ${data.totalCalculations}",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 26,
                  color: Colors.grey[300],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              SizedBox(
                width: screenWidth,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currentIndex == 1 && currentOperator != "-"
                              ? ""
                              : currentOperator,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 66,
                            color: Colors.grey[500],
                            height: 1.0,
                          ),
                        ),
                        Text(
                          currentOperand,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 78,
                            color: Colors.grey[600],
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(flex: 4, child: Container()),
            ],
          ),
        ),
      ],
    );
  }

  Widget inputWidget(BuildContext buildContext) {
    return Center(
      child: Column(
        children: [
          Container(height: 150),
          Text(
            "enter your answer:",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 26,
              color: Colors.grey[300],
            ),
          ),
          data.decimals == 0
              ? Container()
              : Text(
                  "(${data.decimals} decimal ${data.decimals == 1 ? 'place' : 'places'})",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: Colors.grey[300],
                  ),
                ),
          Container(height: 100),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 64.0, vertical: 8.0),
            child: TextField(
              autofocus: true,
              controller: resultController,
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
              onSubmitted: (value) {
                checkAnswer(double.parse(value));
              },
            ),
          ),
          Container(height: 40),
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
                  "submit",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
            onTap: () {
              checkAnswer(double.parse(resultController.text));
            },
          ),
        ],
      ),
    );
  }

  Widget resultWidget(BuildContext buildContext) {
    return Center(
      child: Column(
        children: [
          Expanded(flex: 2, child: Container()),
          Text(
            result ? "correct!" : "wrong!",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 36,
              color: result ? Colors.green[200] : Colors.red[200],
            ),
          ),
          result
              ? Column(
                  children: [
                    Container(height: 75),
                    Text(
                      "the answer was",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        color: Colors.grey[300],
                      ),
                    ),
                    Text(
                      data.decimals == 0
                          ? answer.toInt().toString()
                          : answer.toString(),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 32,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(height: 75),
                    Text(
                      "the correct answer was",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        color: Colors.grey[300],
                      ),
                    ),
                    Text(
                      data.decimals == 0
                          ? answer.toInt().toString()
                          : answer.toString(),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 32,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
          Expanded(flex: 2, child: Container()),
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
                    return MentalCalculation(mentalCalculationData: data);
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
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }

  // helper methods

  void updateCalculation() {
    if (currentIndex == data.totalCalculations) {
      setState(() {
        gameState = GameState.input;
      });
      return;
    }

    if (_timer.isActive) {
      _timer.cancel();
    }

    final Random random = Random();

    // OPERANDS: 0-addition 1-subtraction 2-multiplication

    List<int> operators = [];

    if (data.addition) operators.add(0);
    if (data.subtraction) operators.add(1);
    if (data.multiplication) operators.add(2);

    // lower the probability of addition and subtraction if multiplication numbers are low
    double totalOperands = (data.rangeEnd - data.rangeStart).toDouble();
    double totalOperandsMul = data.mulMax.toDouble();
    bool lowMul =
        totalOperandsMul / (totalOperandsMul + totalOperands) >= (1.0 / 3.0);

    if (data.multiplication && (data.addition || data.subtraction) && lowMul) {
      for (int i = 0; i < 4; i++) {
        if (data.addition) operators.add(0);
        if (data.subtraction) operators.add(1);
      }
    }

    int operator = operators[random.nextInt(operators.length)];

    double operand = 0;

    if (data.decimals == 0) {
      operand =
          (random.nextInt(data.rangeEnd - data.rangeStart) + data.rangeStart)
              .toDouble();
    } else {
      String decimals = "";
      for (int i = 0; i < data.decimals; i++) {
        decimals += random.nextInt(10).toString();
      }
      operand = double.parse(
          "${(random.nextInt(data.rangeEnd + data.rangeStart) + data.rangeStart).toString()}.$decimals");
    }

    if (operator == 2) {
      operand = random.nextInt(data.mulMax - 1) + 2.0;
    }

    if (operator == 2 && currentIndex == 0) {
      answer = 1.0;
    }

    switch (operator) {
      case 0:
        answer += operand;
        break;

      case 1:
        answer -= operand;
        break;

      case 2:
        answer *= operand;
        break;
    }

    if (data.autoMode) {
      int time = data.autoTimer;

      startTimer(time);
    }

    setState(() {
      currentIndex++;
      currentOperator = ["+", "-", "×"][operator];
      currentOperand =
          data.decimals == 0 ? operand.toInt().toString() : operand.toString();
    });
  }

  void checkAnswer(double userAnswer) async {
    String answerStr = answer.toString();

    if (data.decimals != 0) {
      answer = double.parse(
          answerStr.substring(0, answerStr.indexOf('.') + data.decimals + 1));
    } else {
      answer = double.parse(answer.toInt().toString());
    }

    result = userAnswer == answer;

    await saveResult();

    setState(() {
      gameState = GameState.result;
    });
  }

  Future<void> saveResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (result) {
      prefs.setInt(Prefs_MentalCalcCorrectAnswers,
          prefs.getInt(Prefs_MentalCalcCorrectAnswers)! + 1);
    } else {
      prefs.setInt(Prefs_MentalCalcWrongAnswers,
          prefs.getInt(Prefs_MentalCalcWrongAnswers)! + 1);
    }
  }

  // autoTimer

  late Timer _timer;

  void startTimer(int duration) {
    duration--;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (duration == 0) {
          timerFinished();
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            duration--;
          });
        }
      },
    );
  }

  void timerFinished() {
    updateCalculation();
  }
}

class MentalCalculationData {
  int totalCalculations;
  int rangeStart;
  int rangeEnd;
  int decimals;
  bool addition;
  bool subtraction;
  bool multiplication;
  bool autoMode;
  int autoTimer;
  int mulMax;

  MentalCalculationData(
    this.totalCalculations,
    this.rangeStart,
    this.rangeEnd,
    this.decimals,
    this.addition,
    this.subtraction,
    this.multiplication,
    this.autoMode,
    this.autoTimer,
    this.mulMax,
  );
}

enum GameState {
  playing,
  input,
  result,
}
