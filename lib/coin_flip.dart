import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class CoinFlip extends StatefulWidget {
  const CoinFlip({Key? key, this.devModeOn}) : super(key: key);
  final devModeOn;

  @override
  // ignore: no_logic_in_create_state
  CoinFlipState createState() => CoinFlipState(devModeOn);
}

class CoinFlipState extends State<CoinFlip> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: ui.Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  );
  // ignore: prefer_typing_uninitialized_variables
  final devModeOn;

  bool var1 = false;
  bool var2 = false;
  bool win = false;
  var topWin = 0;
  var rng = Random();

  int randInt = 0;
  CoinFlipState(this.devModeOn);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    double height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;
    gesture() async {
      if (var1 == true) {
        if (var2 == true) {
          ("tapped");
          setState(() {
            randInt = Random().nextInt(2);
          });
          if (randInt == 0) {
            setState(() {
              topWin = 1;
              (topWin);
            });
          } else {
            setState(() {
              topWin = 2;
              (topWin);
            });
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
            ));
      });
    }
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            systemStatusBarContrastEnforced: false,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        sized: false,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CupertinoPageScaffold(
                child: Scaffold(
                    backgroundColor: Colors.black,
                    extendBodyBehindAppBar: true,
                    body: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            GestureDetector(
                                onLongPressDown: ((details) => {
                                      setState(() {
                                        var1 = true;
                                      }),
                                    }),
                                onLongPressStart: ((details) => {
                                      Vibration.vibrate(
                                          duration: 10, amplitude: 128),
                                      setState(() {
                                        var1 = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressEnd: ((details) => {
                                      Vibration.vibrate(
                                          duration: 10, amplitude: 128),
                                      setState(() {
                                        var1 = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressCancel: () {
                                  Vibration.vibrate(
                                      duration: 10, amplitude: 128);
                                  setState(() {
                                    var1 = false;
                                  });
                                  gesture();
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: (height / 2) - 20,
                                        child: Hero(
                                            tag: 'top',
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
                                                        child: Stack(children: [
                                                          Container(
                                                            color: const ui
                                                                    .Color.fromARGB(
                                                                255,
                                                                7,
                                                                69,
                                                                255),
                                                          ),
                                                          const RotatedBox(
                                                              quarterTurns: 2,
                                                              child: Center(
                                                                  child: Text(
                                                                      'Ready',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              30))))
                                                        ])),
                                                  ],
                                                )))))),
                            const CupertinoNavigationBar(
                              middle: Text('Coin Flip',
                                  style: TextStyle(color: Colors.white)),
                              automaticallyImplyLeading: true,
                              previousPageTitle: "Home",
                              transitionBetweenRoutes: true,
                              border: null,
                              backgroundColor: Colors.black,
                            ),
                            GestureDetector(
                                onLongPressDown: ((details) => {
                                      setState(() {
                                        var2 = true;
                                      }),
                                    }),
                                onLongPressStart: ((details) => {
                                      Vibration.vibrate(
                                          duration: 10, amplitude: 128),
                                      setState(() {
                                        var2 = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressEnd: ((details) => {
                                      Vibration.vibrate(
                                          duration: 10, amplitude: 128),
                                      setState(() {
                                        var2 = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressCancel: () {
                                  Vibration.vibrate(
                                      duration: 10, amplitude: 128);
                                  setState(() {
                                    var2 = false;
                                  });
                                  gesture();
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(bottom: 55),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: (height / 2) - 20,
                                        child: Hero(
                                            tag: 'bottom',
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        color: const ui
                                                                .Color.fromARGB(
                                                            147, 79, 38, 38)),
                                                    Visibility(
                                                        visible: var2,
                                                        child: Stack(children: [
                                                          Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  0,
                                                                  0)),
                                                          const Center(
                                                              child: Text(
                                                                  'Ready',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          30)))
                                                        ])),
                                                  ],
                                                )))))),
                          ],
                        ))))));
  }
}

class Win extends StatelessWidget {
  final topWin;
  final devModeOn;

  const Win({super.key, required this.topWin, this.devModeOn});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;
    return ClipRRect(
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
                      child: GestureDetector(
                          onTap: () {
                            Vibration.vibrate(duration: 10, amplitude: 128);
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => CoinFlip(
                                    devModeOn: devModeOn,
                                  ),
                                ));
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: height,
                                  child: Hero(
                                      tag: topWin == 1 ? 'top' : 'bottom',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          child: Container(
                                            color: topWin == 1
                                                ? const ui.Color.fromARGB(
                                                    255, 7, 69, 255)
                                                : const ui.Color.fromARGB(
                                                    255, 255, 0, 0),
                                          )))))),
                    )))));
  }
}
