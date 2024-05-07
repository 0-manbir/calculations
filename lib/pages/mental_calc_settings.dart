import 'package:calculations/pages/mental_calc.dart';
import 'package:calculations/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentalCalculationSettings extends StatefulWidget {
  const MentalCalculationSettings({super.key});

  @override
  State<MentalCalculationSettings> createState() =>
      _MentalCalculationSettingsState();
}

class _MentalCalculationSettingsState extends State<MentalCalculationSettings> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();

    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    // methods getting shared prefs
    getValues();
  }

  @override
  Widget build(BuildContext context) {
    // variables
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
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

                // main body---------------------------------------------------------------------
                Expanded(
                  child: Column(
                    children: [
                      Container(height: 25),
                      Text(
                        "settings:",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        "(auto saved)",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.grey[300],
                        ),
                      ),
                      Container(height: 30),

                      // operators-----------------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "addition:",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                            Expanded(child: Container()),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: operatorsToggles[0],
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.grey[500],
                                inactiveThumbColor: Colors.grey[500],
                                inactiveTrackColor: Colors.grey[300],
                                trackOutlineColor:
                                    MaterialStateProperty.all(Colors.grey[500]),
                                onChanged: (value) {
                                  HapticFeedback.mediumImpact();
                                  setState(() {
                                    operatorsToggles[0] = value;
                                  });
                                },
                              ),
                            ),
                            Container(width: 60),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "subtraction:",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                            Expanded(child: Container()),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: operatorsToggles[1],
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.grey[500],
                                inactiveThumbColor: Colors.grey[500],
                                inactiveTrackColor: Colors.grey[300],
                                trackOutlineColor:
                                    MaterialStateProperty.all(Colors.grey[500]),
                                onChanged: (value) {
                                  HapticFeedback.mediumImpact();
                                  setState(() {
                                    operatorsToggles[1] = value;
                                  });
                                },
                              ),
                            ),
                            Container(width: 60),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "multiplication:",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                            Expanded(child: Container()),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: operatorsToggles[2],
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.grey[500],
                                inactiveThumbColor: Colors.grey[500],
                                inactiveTrackColor: Colors.grey[300],
                                trackOutlineColor:
                                    MaterialStateProperty.all(Colors.grey[500]),
                                onChanged: (value) {
                                  HapticFeedback.mediumImpact();
                                  setState(() {
                                    operatorsToggles[2] = value;
                                  });
                                },
                              ),
                            ),
                            Container(width: 60),
                          ],
                        ),
                      ),

                      // multiplication max no---------------------
                      operatorsToggles[2]
                          ? Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "max number:",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  Container(width: 15),
                                  Expanded(
                                    child: TextField(
                                      controller: mulMaxController,
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
                                        hintText: ".........",
                                        hintStyle: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != "") {
                                          _prefs.setInt(
                                              Prefs_MulMax, int.parse(value));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),

                      Container(height: 30),

                      // total calculations-----------------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "total calculations:",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                            Container(width: 15),
                            Expanded(
                              child: TextField(
                                controller: totalCalcsController,
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
                                  hintText: ".........",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value != "") {
                                    _prefs.setInt(
                                        Prefs_TotalCalcs, int.parse(value));
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // decimal digits----------------------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "decimal digits:",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                            Container(width: 15),
                            Expanded(
                              child: TextField(
                                controller: decimalsController,
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
                                  hintText: ".........",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value != "") {
                                    _prefs.setInt(
                                        Prefs_DecimalPlaces, int.parse(value));
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // numbers range--------------------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "from:",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                            Container(width: 15),
                            Expanded(
                              child: TextField(
                                controller: rangeStartController,
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
                                  hintText: ".........",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value != "") {
                                    _prefs.setInt(
                                        Prefs_RangeStart, int.parse(value));
                                  }
                                },
                              ),
                            ),
                            Text(
                              "to:",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                            Container(width: 15),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: rangeEndController,
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
                                  hintText: ".........",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value != "") {
                                    _prefs.setInt(
                                        Prefs_RangeEnd, int.parse(value));
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(height: 30),

                      // automatic mode------------------------------------
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "automatic:",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                color: Colors.grey[400],
                              ),
                            ),
                            Expanded(child: Container()),
                            Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: automaticMode,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.grey[500],
                                inactiveThumbColor: Colors.grey[500],
                                inactiveTrackColor: Colors.grey[300],
                                trackOutlineColor:
                                    MaterialStateProperty.all(Colors.grey[500]),
                                onChanged: (value) {
                                  HapticFeedback.mediumImpact();
                                  setState(() {
                                    automaticMode = value;
                                  });
                                },
                              ),
                            ),
                            Container(width: 60),
                          ],
                        ),
                      ),

                      // automatic mode - auto timer time---------------------
                      automaticMode
                          ? Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "delay (seconds):",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  Container(width: 15),
                                  Expanded(
                                    child: TextField(
                                      controller: timerController,
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
                                        hintText: ".........",
                                        hintStyle: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != "") {
                                          _prefs.setInt(Prefs_AutoTimer,
                                              int.parse(value));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),

                // start button----------------------------------------------------------
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      "start",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  onTap: () {
                    HapticFeedback.mediumImpact();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MentalCalculation(
                            mentalCalculationData: MentalCalculationData(
                              int.parse(totalCalcsController.text),
                              int.parse(rangeStartController.text),
                              int.parse(rangeEndController.text),
                              int.parse(decimalsController.text),
                              operatorsToggles[0],
                              operatorsToggles[1],
                              operatorsToggles[2],
                              automaticMode,
                              int.parse(timerController.text),
                              int.parse(mulMaxController.text),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                Container(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // values
  final TextEditingController totalCalcsController = TextEditingController();
  final TextEditingController rangeStartController = TextEditingController();
  final TextEditingController rangeEndController = TextEditingController();
  final TextEditingController decimalsController = TextEditingController();
  final TextEditingController timerController = TextEditingController();
  final TextEditingController mulMaxController = TextEditingController();

  List<bool> operatorsToggles = [true, true, false];
  bool automaticMode = false;

  void getValues() {
    saveValues();

    setState(() {
      totalCalcsController.text = _prefs.getInt(Prefs_TotalCalcs)!.toString();
      rangeStartController.text = _prefs.getInt(Prefs_RangeStart)!.toString();
      rangeEndController.text = _prefs.getInt(Prefs_RangeEnd)!.toString();
      decimalsController.text = _prefs.getInt(Prefs_DecimalPlaces)!.toString();
      timerController.text = _prefs.getInt(Prefs_AutoTimer)!.toString();
      mulMaxController.text = _prefs.getInt(Prefs_MulMax)!.toString();
    });
  }

  // ensures that values are intialized in prefs
  void saveValues() {
    if (!_prefs.containsKey(Prefs_TotalCalcs)) {
      _prefs.setInt(Prefs_TotalCalcs, 10);
    }
    if (!_prefs.containsKey(Prefs_RangeStart)) {
      _prefs.setInt(Prefs_RangeStart, 1);
    }
    if (!_prefs.containsKey(Prefs_RangeEnd)) {
      _prefs.setInt(Prefs_RangeEnd, 100);
    }
    if (!_prefs.containsKey(Prefs_DecimalPlaces)) {
      _prefs.setInt(Prefs_DecimalPlaces, 0);
    }
    if (!_prefs.containsKey(Prefs_AutoTimer)) {
      _prefs.setInt(Prefs_AutoTimer, 10);
    }
    if (!_prefs.containsKey(Prefs_MulMax)) {
      _prefs.setInt(Prefs_MulMax, 10);
    }
  }
}
