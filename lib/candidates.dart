import 'dart:ui' as ui;
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'main.dart';
import 'cands/rishu-sharma.dart';

class CandidatesPage extends StatelessWidget {
  CandidatesPage({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
    statusBarBrightness: ui.Brightness.dark,
  );
  @override
  var devMode = 0;
  final _offsetToArmed = 75.0;
  @override
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
                backgroundColor: const Color(0x00000000),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
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
                                        tag: 'jamal-pic',
                                        transitionOnUserGestures: true,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://cdn.discordapp.com/attachments/823961764185505820/1005070420929687632/Screenshot_20220805-163943_Slides.jpg",
                                            placeholder: (context, url) =>
                                                const SizedBox(
                                                    height: 300,
                                                    width: double.infinity,
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const SizedBox(
                                                        height: 300,
                                                        width: double.infinity,
                                                        child: Icon(Icons.error,
                                                            size: 100)),
                                          ),
                                        )),
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft:
                                                ui.Radius.circular(15.0),
                                            bottomRight:
                                                ui.Radius.circular(15.0)),
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
                                                              .symmetric(
                                                          vertical: 5),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Hero(
                                                                transitionOnUserGestures:
                                                                    true,
                                                                tag:
                                                                    'Jamal_First',
                                                                child:
                                                                    AnimatedTextKit(
                                                                  animatedTexts: [
                                                                    ColorizeAnimatedText(
                                                                      'Jamal ',
                                                                      textStyle:
                                                                          colorizeTextStyle,
                                                                      colors:
                                                                          colorizeColors,
                                                                    ),
                                                                    ColorizeAnimatedText(
                                                                      'Jamal ',
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
                                                                tag:
                                                                    'Jamal-Last',
                                                                child:
                                                                    AnimatedTextKit(
                                                                  animatedTexts: [
                                                                    ColorizeAnimatedText(
                                                                      'Neeway',
                                                                      textStyle:
                                                                          colorizeTextStyle,
                                                                      colors:
                                                                          colorizeColors,
                                                                    ),
                                                                    ColorizeAnimatedText(
                                                                      'Neeway',
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
                                )),
                          ),
                          //bottom padding below
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          )
                        ])))));
  }
}
