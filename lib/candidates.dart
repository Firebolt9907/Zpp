import 'dart:ui' as ui;
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';
import 'cands/rishu-sharma.dart';

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}

_vibrate() {
  Vibration.vibrate(duration: 10, amplitude: 128);
}

class CandidatesPage extends StatelessWidget {
  CandidatesPage({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
    statusBarBrightness: ui.Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  @override
  var devMode = 0;
  final _offsetToArmed = 75.0;
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 40.0,
      fontFamily: 'Horizon',
    );
    // Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Scaffold(
            appBar: CupertinoNavigationBar(
                backgroundColor: Color(0x00000000),
                border: Border.all(color: Colors.transparent),
                previousPageTitle: "Home",
                middle: const Text("Candidates")),
            extendBodyBehindAppBar: true,
            backgroundColor:
                context.isDarkMode == true ? Colors.black : Colors.white,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
                sized: false,
                child: CupertinoPageScaffold(
                    resizeToAvoidBottomInset: false,
                    child: ListView(
                        padding: const EdgeInsets.only(top: 30),
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          const RishuSharma()));
                            },
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Hero(
                                    tag: 'sus',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: const Image(
                                          image: AssetImage('assets/sus.jpg'),
                                        ))),
                                ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: ui.Radius.circular(15.0),
                                        bottomRight: ui.Radius.circular(15.0)),
                                    child: ClipRRect(
                                        // Clip it cleanly.
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: Container(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Hero(
                                                            transitionOnUserGestures:
                                                                true,
                                                            tag: 'Rishu_First',
                                                            child:
                                                                AnimatedTextKit(
                                                              animatedTexts: [
                                                                ColorizeAnimatedText(
                                                                  'Rishu ',
                                                                  textStyle:
                                                                      colorizeTextStyle,
                                                                  colors:
                                                                      colorizeColors,
                                                                ),
                                                                ColorizeAnimatedText(
                                                                  'Rishu ',
                                                                  textStyle:
                                                                      colorizeTextStyle,
                                                                  colors:
                                                                      colorizeColors,
                                                                ),
                                                              ],
                                                              isRepeatingAnimation:
                                                                  true,
                                                            )),
                                                        Hero(
                                                            transitionOnUserGestures:
                                                                true,
                                                            tag: 'Rishu-Last',
                                                            child:
                                                                AnimatedTextKit(
                                                              animatedTexts: [
                                                                ColorizeAnimatedText(
                                                                  'Sharma',
                                                                  textStyle:
                                                                      colorizeTextStyle,
                                                                  colors:
                                                                      colorizeColors,
                                                                ),
                                                                ColorizeAnimatedText(
                                                                  'Sharma',
                                                                  textStyle:
                                                                      colorizeTextStyle,
                                                                  colors:
                                                                      colorizeColors,
                                                                ),
                                                              ],
                                                              isRepeatingAnimation:
                                                                  true,
                                                            )),
                                                      ]),
                                                ))))),
                              ],
                            ),
                          ),
                          //bottom padding below
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          )
                        ])))));
  }
}
