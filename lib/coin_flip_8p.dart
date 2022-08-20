import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:Zpp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class CoinFlip8p extends StatefulWidget {
  const CoinFlip8p({Key? key, this.devModeOn}) : super(key: key);
  final devModeOn;

  @override
  // ignore: no_logic_in_create_state
  CoinFlipState createState() => CoinFlipState(devModeOn);
}

class CoinFlipState extends State<CoinFlip8p> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  );
  // ignore: prefer_typing_uninitialized_variables
  final devModeOn;

  bool var1 = false;
  bool var2 = false;
  bool var3 = false;
  bool var4 = false;
  bool var5 = false;
  bool var6 = false;
  bool var7 = false;
  bool var8 = false;
  bool win = false;
  var topWin = 0;
  var rng = Random();

  int randInt = 0;
  CoinFlipState(this.devModeOn);
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    double height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    gesture() async {
      if (var1 == true) {
        if (var2 == true) {
          if (var3 == true) {
            if (var4 == true) {
              if (var5 == true) {
                if (var6 == true) {
                  if (var7 == true) {
                    if (var8 == true) {
                      ("tapped");
                      setState(() {
                        randInt = Random().nextInt(8);
                      });
                      if (randInt == 0) {
                        setState(() {
                          topWin = 1;
                          (topWin);
                        });
                      } else if (randInt == 1) {
                        setState(() {
                          topWin = 2;
                          (topWin);
                        });
                      } else if (randInt == 2) {
                        setState(() {
                          topWin = 3;
                          (topWin);
                        });
                      } else if (randInt == 3) {
                        setState(() {
                          topWin = 4;
                          (topWin);
                        });
                      } else if (randInt == 4) {
                        setState(() {
                          topWin = 5;
                          (topWin);
                        });
                      } else if (randInt == 5) {
                        setState(() {
                          topWin = 6;
                          (topWin);
                        });
                      } else if (randInt == 6) {
                        setState(() {
                          topWin = 7;
                          (topWin);
                        });
                      } else {
                        setState(() {
                          topWin = 8;
                          (topWin);
                        });
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    if (topWin == 0) {
      null;
    } else {
      Future.delayed(Duration.zero, () async {
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => Win(
                topWin: topWin,
                devModeOn: devModeOn,
              ),
            )); //.then((value) {
        //   setState(() {
        //     top = false;
        //     var2= false;
        //     bottom = false;
        //     topWin = 0;
        //   });
        // });
      });
    }
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            systemStatusBarContrastEnforced: false,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarContrastEnforced: false,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        sized: false,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CupertinoPageScaffold(
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    appBar: const CupertinoNavigationBar(
                      middle: Text('Coin Flip',
                          style: TextStyle(color: Colors.white)),
                      automaticallyImplyLeading: true,
                      previousPageTitle: "Home",
                      transitionBetweenRoutes: true,
                      border: null,
                      backgroundColor: Colors.black,
                    ),
                    backgroundColor: Colors.black,
                    extendBodyBehindAppBar: true,
                    body: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 4),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  var1 = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var1 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var1 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              var1 = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'var1',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              149, 47, 48, 84)),
                                                      Visibility(
                                                          visible: var1,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  69,
                                                                  255),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, left: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 4),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  var2 = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var2 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var2 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              var2 = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'var2',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              148, 54, 84, 47)),
                                                      Visibility(
                                                          visible: var2,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  255,
                                                                  0),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 3,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                            ]),
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 4),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  var3 = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var3 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var3 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              var3 = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'var3',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              148, 79, 47, 84)),
                                                      Visibility(
                                                          visible: var3,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  210,
                                                                  7,
                                                                  255),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, left: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 4),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  var4 = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var4 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var4 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              var4 = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'var4',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              147, 84, 47, 47)),
                                                      Visibility(
                                                          visible: var4,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  0,
                                                                  0),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 3,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                            ]),
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 4),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  var5 = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var5 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var5 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              var5 = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'var5',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              146, 79, 61, 38)),
                                                      Visibility(
                                                          visible: var5,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  123,
                                                                  0),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, left: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 4),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  var6 = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var6 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var6 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              var6 = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'var6',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              146, 47, 81, 84)),
                                                      Visibility(
                                                          visible: var6,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  234,
                                                                  255),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 3,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                            ]),
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 4),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  var7 = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var7 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var7 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              var7 = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'var7',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              146, 55, 38, 79)),
                                                      Visibility(
                                                          visible: var7,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  106,
                                                                  0,
                                                                  255),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, left: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 4),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  var8 = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var8 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  var8 = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              var8 = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'var8',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              146, 32, 85, 37)),
                                                      Visibility(
                                                          visible: var8,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  110,
                                                                  11),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 3,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                            ]),
                          ],
                        ))))));
  }
}

class Win extends StatelessWidget {
  final topWin;
  final height;
  final devModeOn;

  const Win({super.key, required this.topWin, this.height, this.devModeOn});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;
    return GestureDetector(
        onTap: () {
          Platform.isMacOS == true
              ? null
              : Vibration.vibrate(duration: 10, amplitude: 128);
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => CoinFlip8p(
                  devModeOn: devModeOn,
                ),
              ));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CupertinoPageScaffold(
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                        systemStatusBarContrastEnforced: false,
                        systemNavigationBarColor: Colors.transparent,
                        systemNavigationBarDividerColor: Colors.transparent,
                        systemNavigationBarIconBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.light),
                    sized: false,
                    child: Scaffold(
                      backgroundColor: Colors.black,
                      extendBodyBehindAppBar: true,
                      body: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: height,
                                  child: Hero(
                                      tag: topWin == 1
                                          ? 'var1'
                                          : topWin == 2
                                              ? 'var2'
                                              : topWin == 3
                                                  ? 'var3'
                                                  : topWin == 4
                                                      ? 'var4'
                                                      : topWin == 5
                                                          ? 'var5'
                                                          : topWin == 6
                                                              ? 'var6'
                                                              : topWin == 7
                                                                  ? 'var7'
                                                                  : 'var8',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          child: Container(
                                            color: topWin == 1
                                                ? const ui.Color.fromARGB(
                                                    255, 7, 69, 255)
                                                : topWin == 2
                                                    ? const ui.Color.fromARGB(
                                                        255, 0, 255, 0)
                                                    : topWin == 3
                                                        ? const ui.Color.fromARGB(
                                                            255, 210, 7, 255)
                                                        : topWin == 4
                                                            ? const ui.Color.fromARGB(
                                                                255, 255, 0, 0)
                                                            : topWin == 5
                                                                ? const ui.Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    123,
                                                                    0)
                                                                : topWin == 6
                                                                    ? const ui
                                                                            .Color.fromARGB(
                                                                        255,
                                                                        0,
                                                                        234,
                                                                        255)
                                                                    : topWin ==
                                                                            7
                                                                        ? const ui.Color.fromARGB(
                                                                            255,
                                                                            106,
                                                                            0,
                                                                            255)
                                                                        : const ui.Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            110,
                                                                            11),
                                          )))))),
                    )))));
  }
}
