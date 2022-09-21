import 'dart:ui' as ui;
import 'dart:ui';
import 'package:Zpp/my_social.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tab;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:iconforest_arcticons/arcticons.dart';
import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:swipe_deck/swipe_deck.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:card_swiper/card_swiper.dart';

import 'secret_menu.dart';
import 'main.dart';

const IMAGES = [
  'rishi',
  'nick',
  'rohan',
  'amogus',
  'isaac',
  'filmon',
];

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

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key, this.darkDynamic, this.lightDynamic})
      : super(key: key);
  final darkDynamic;
  final lightDynamic;
  @override
  AboutUsState createState() => AboutUsState();
}

class AboutUsState extends State<AboutUs> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
    statusBarBrightness: ui.Brightness.dark,
  );
  @override
  void dispose() {
    super.dispose();
  }

  @override
  var indexItem = 'amogus';
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
        borderRadius: BorderRadius.circular(8.0),
        child: Scaffold(
            backgroundColor: context.isDarkMode == true
                ? widget.darkDynamic?.background ?? Colors.black
                : widget.lightDynamic?.background ?? Colors.white,
            appBar: CupertinoNavigationBar(
                backgroundColor: context.isDarkMode == true
                    ? widget.darkDynamic?.background ?? Colors.black
                    : widget.lightDynamic?.background ?? Colors.white,
                border: Border.all(color: Colors.transparent),
                previousPageTitle: "Settings",
                middle: const Text("My Friends")),
            extendBodyBehindAppBar: true,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  statusBarColor: const ui.Color.fromARGB(0, 0, 0, 0),
                  systemNavigationBarIconBrightness: context.isDarkMode == true
                      ? Brightness.light
                      : Brightness.dark,
                ),
                sized: false,
                child: CupertinoPageScaffold(
                    backgroundColor: context.isDarkMode == true
                        ? widget.darkDynamic?.background ?? Colors.black
                        : widget.lightDynamic?.background ?? Colors.white,
                    resizeToAvoidBottomInset: false,
                    child: ListView(
                        // physics: const NeverScrollableScrollPhysics(),
                        // physics: indexItem == 'amogus'
                        //     ? const ScrollPhysics()
                        //     : const NeverScrollableScrollPhysics(),
                        physics: const ScrollPhysics(),
                        reverse: false,
                        padding: const EdgeInsets.only(top: 120),
                        children: [
                          Bounceable(
                              onTap: () {},
                              child: SwipeDeck(
                                startIndex: 3,
                                cardSpreadInDegrees:
                                    5.0, // Change the Spread of Background Cards
                                onSwipeLeft: () {},
                                onSwipeRight: () {},
                                onChange: (index) {
                                  setState(() {
                                    indexItem = IMAGES[index];
                                  });
                                },
                                widgets: IMAGES
                                    .map((e) => Bounceable(
                                          onTap: () {
                                            if (indexItem == 'amogus') {
                                              _launchURL(
                                                  'https://www.snapchat.com/add/firebolt_9907?share_id=6bLdC4GNgg8&locale=en-US');
                                            } else if (indexItem == 'rishi') {
                                              _launchURL(
                                                  "https://discordapp.com/users/669357017307283456");
                                            } else if (indexItem == 'nick') {
                                              _launchURL(
                                                  "https://discordapp.com/users/784825209407799297");
                                            } else if (indexItem == 'filmon') {
                                              _launchURL(
                                                  "https://www.snapchat.com/add/filmon_king?share_id=MzhGODlBRkYtMEJERC00NjkwLTg4M0MtQUNGNTFERUZDOTFC&locale=en_US");
                                            } else if (indexItem == 'isaac') {
                                              _launchURL(
                                                  "https://discordapp.com/users/782137166327054358");
                                            } else if (indexItem == 'rohan') {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const YourMomJokes()));
                                            }
                                          },
                                          child: e == 'amogus'
                                              ? Hero(
                                                  tag: 'sus',
                                                  transitionOnUserGestures:
                                                      indexItem == 'amogus'
                                                          ? true
                                                          : false,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.asset(
                                                        "assets/amogus.jpg",
                                                        fit: BoxFit.cover,
                                                      )))
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: Image.asset(
                                                    "assets/$e.jpg",
                                                    fit: BoxFit.cover,
                                                  )),
                                        ))
                                    .toList(),
                              )),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          ),
                          SizedBox(
                              height: 150,
                              child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Align(
                                      alignment: const Alignment(0.0, 1.0),
                                      child: indexItem == 'amogus'
                                          ? Text(
                                              'dedicaded many weeks to breaking Stack Overflow and his CTRL, C, and V keys',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: context.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ))
                                          : indexItem == 'rishi'
                                              ? Text(
                                                  'did so much work on the app only to not click push changes',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: context.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ))
                                              : indexItem == 'filmon'
                                                  ? Text(
                                                      'dedicated his entire summer to play CSGO, aim still garbage',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                      ))
                                                  : indexItem == 'nick'
                                                      ? Text(
                                                          'made the universe, forgot to create the app',
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ))
                                                      : indexItem == 'rohan'
                                                          ? Text(
                                                              'told Rishu to make a ur mom jokes page in this',
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: context
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ))
                                                          : indexItem == 'isaac'
                                                              ? Text(
                                                                  'waiting for isaac to send desc',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    color: context.isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ))
                                                              : Text(
                                                                  'waiting for isaac to send desc',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    color: context.isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ))))),
                          indexItem == 'amogus'
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Bounceable(
                                      onTap: () {},
                                      child: AnimatedTextKit(
                                        key: UniqueKey(),
                                        animatedTexts: [
                                          ColorizeAnimatedText(
                                            'Rishu Sharma',
                                            textStyle: colorizeTextStyle,
                                            colors: colorizeColors,
                                          ),
                                          ColorizeAnimatedText(
                                            'Rishu Sharma',
                                            textStyle: colorizeTextStyle,
                                            colors: colorizeColors,
                                          ),
                                        ],
                                        isRepeatingAnimation: true,
                                      )))
                              : indexItem == 'rishi'
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: Bounceable(
                                          onTap: () {},
                                          child: AnimatedTextKit(
                                            key: UniqueKey(),
                                            animatedTexts: [
                                              ColorizeAnimatedText(
                                                'Rishi Vennapusa',
                                                textStyle: colorizeTextStyle,
                                                colors: colorizeColors,
                                              ),
                                              ColorizeAnimatedText(
                                                'Rishi Vennapusa',
                                                textStyle: colorizeTextStyle,
                                                colors: colorizeColors,
                                              ),
                                            ],
                                            isRepeatingAnimation: true,
                                          )))
                                  : indexItem == 'filmon'
                                      ? Align(
                                          alignment: Alignment.topCenter,
                                          child: Bounceable(
                                              onTap: () {},
                                              child: AnimatedTextKit(
                                                key: UniqueKey(),
                                                animatedTexts: [
                                                  ColorizeAnimatedText(
                                                    'Filmon Negash',
                                                    textStyle:
                                                        colorizeTextStyle,
                                                    colors: colorizeColors,
                                                  ),
                                                  ColorizeAnimatedText(
                                                    'Filmon Negash',
                                                    textStyle:
                                                        colorizeTextStyle,
                                                    colors: colorizeColors,
                                                  ),
                                                ],
                                                isRepeatingAnimation: true,
                                              )))
                                      : indexItem == 'nick'
                                          ? Align(
                                              alignment: Alignment.topCenter,
                                              child: Bounceable(
                                                  onTap: () {},
                                                  child: AnimatedTextKit(
                                                    key: UniqueKey(),
                                                    animatedTexts: [
                                                      ColorizeAnimatedText(
                                                        'Nick Smith',
                                                        textStyle:
                                                            colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      ),
                                                      ColorizeAnimatedText(
                                                        'Nick Smith',
                                                        textStyle:
                                                            colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      ),
                                                    ],
                                                    isRepeatingAnimation: true,
                                                  )))
                                          : indexItem == 'rohan'
                                              ? Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Bounceable(
                                                      onTap: () {},
                                                      child: AnimatedTextKit(
                                                        key: UniqueKey(),
                                                        animatedTexts: [
                                                          ColorizeAnimatedText(
                                                            'Rohan George',
                                                            textStyle:
                                                                colorizeTextStyle,
                                                            colors:
                                                                colorizeColors,
                                                          ),
                                                          ColorizeAnimatedText(
                                                            'Rohan George',
                                                            textStyle:
                                                                colorizeTextStyle,
                                                            colors:
                                                                colorizeColors,
                                                          ),
                                                        ],
                                                        isRepeatingAnimation:
                                                            true,
                                                      )))
                                              : indexItem == 'isaac'
                                                  ? Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Bounceable(
                                                          onTap: () {},
                                                          child:
                                                              AnimatedTextKit(
                                                            key: UniqueKey(),
                                                            animatedTexts: [
                                                              ColorizeAnimatedText(
                                                                'Isaac Durr',
                                                                textStyle:
                                                                    colorizeTextStyle,
                                                                colors:
                                                                    colorizeColors,
                                                              ),
                                                              ColorizeAnimatedText(
                                                                'Isaac Durr',
                                                                textStyle:
                                                                    colorizeTextStyle,
                                                                colors:
                                                                    colorizeColors,
                                                              ),
                                                            ],
                                                            isRepeatingAnimation:
                                                                true,
                                                          )))
                                                  : Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Bounceable(
                                                          onTap: () {},
                                                          child:
                                                              AnimatedTextKit(
                                                            key: UniqueKey(),
                                                            animatedTexts: [
                                                              ColorizeAnimatedText(
                                                                'Dependencies',
                                                                textStyle:
                                                                    colorizeTextStyle,
                                                                colors:
                                                                    colorizeColors,
                                                              ),
                                                              ColorizeAnimatedText(
                                                                'Dependencies',
                                                                textStyle:
                                                                    colorizeTextStyle,
                                                                colors:
                                                                    colorizeColors,
                                                              ),
                                                            ],
                                                            isRepeatingAnimation:
                                                                true,
                                                          ))),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 20, right: 20),
                              child: Align(
                                  alignment: const Alignment(0.0, 1.0),
                                  child: indexItem == 'amogus'
                                      ? Column(children: [
                                          Dismissible(
                                              resizeDuration: const Duration(
                                                  milliseconds: 10),
                                              direction:
                                                  DismissDirection.startToEnd,
                                              onDismissed: (dismissed) {
                                                _launchURL(
                                                    "https://discordapp.com/users/624016207774875669");
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  setState(() {});
                                                });
                                              },
                                              onUpdate: (details) {},
                                              key: UniqueKey(),
                                              background: const Center(
                                                  child: Text('Add on Discord',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.white))),
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  height: 60,
                                                  child: Bounceable(
                                                      onTap: () {},
                                                      child: CupertinoButton(
                                                        color: const ui
                                                                .Color.fromARGB(
                                                            255, 88, 101, 242),
                                                        child: const Text(
                                                            'Add on Discord',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        onPressed: () {
                                                          _launchURL(
                                                              "https://discordapp.com/users/624016207774875669");
                                                        },
                                                      )))),
                                          const Padding(
                                              padding: EdgeInsets.only(top: 8)),
                                          Dismissible(
                                              resizeDuration: const Duration(
                                                  milliseconds: 10),
                                              direction:
                                                  DismissDirection.startToEnd,
                                              onDismissed: (dismissed) {
                                                _launchURL(
                                                    "https://instagram.com/firebolt_9907?igshid=YmMyMTA2M2Y=");
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  setState(() {});
                                                });
                                              },
                                              onUpdate: (details) {},
                                              key: UniqueKey(),
                                              background: const Center(
                                                  child: Text(
                                                      'Follow on Instagram',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.white))),
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  height: 60,
                                                  child: Bounceable(
                                                      onTap: () {},
                                                      child: Container(
                                                        height: 44.0,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                gradient: const LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                    colors: [
                                                                      ui.Color.fromARGB(
                                                                          255,
                                                                          254,
                                                                          218,
                                                                          117),
                                                                      ui.Color.fromARGB(
                                                                          255,
                                                                          250,
                                                                          126,
                                                                          30),
                                                                      ui.Color.fromARGB(
                                                                          255,
                                                                          214,
                                                                          41,
                                                                          118),
                                                                      ui.Color.fromARGB(
                                                                          255,
                                                                          150,
                                                                          47,
                                                                          191),
                                                                      ui.Color.fromARGB(
                                                                          255,
                                                                          79,
                                                                          91,
                                                                          213),
                                                                    ])),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            _launchURL(
                                                                "https://instagram.com/firebolt_9907?igshid=YmMyMTA2M2Y=");
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              primary: Colors
                                                                  .transparent,
                                                              shadowColor: Colors
                                                                  .transparent),
                                                          child: const Text(
                                                              'Follow on Instagram',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      )))),
                                          const Padding(
                                              padding: EdgeInsets.only(top: 8)),
                                          Dismissible(
                                              resizeDuration: const Duration(
                                                  milliseconds: 10),
                                              direction:
                                                  DismissDirection.startToEnd,
                                              onDismissed: (dismissed) {
                                                _launchURL(
                                                    "https://www.snapchat.com/add/firebolt_9907?share_id=6bLdC4GNgg8&locale=en-US");
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  setState(() {});
                                                });
                                              },
                                              onUpdate: (details) {},
                                              key: UniqueKey(),
                                              background: const Center(
                                                  child: Text('Add on Snapchat',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.white))),
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  height: 60,
                                                  child: Bounceable(
                                                      onTap: () {},
                                                      child: CupertinoButton(
                                                        color: const ui
                                                                .Color.fromARGB(
                                                            255, 255, 252, 0),
                                                        child: const Text(
                                                            'Add on Snapchat',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black)),
                                                        onPressed: () {
                                                          _launchURL(
                                                              "https://www.snapchat.com/add/firebolt_9907?share_id=6bLdC4GNgg8&locale=en-US");
                                                        },
                                                      )))),
                                          const Padding(
                                              padding: EdgeInsets.only(top: 8)),
                                          // SizedBox(
                                          //     width: double.infinity - 40,
                                          //     height: 60,
                                          //     child: Bounceable(
                                          //         onTap: () {},
                                          //         child: CupertinoButton.filled(
                                          //           padding: EdgeInsets.zero,
                                          //           child: const Text(
                                          //               'View Socials',
                                          //               style: TextStyle(
                                          //                   fontSize: 20,
                                          //                   fontWeight:
                                          //                       FontWeight
                                          //                           .bold)),
                                          //           onPressed: () {
                                          //             Navigator.push(
                                          //                 context,
                                          //                 CupertinoPageRoute(
                                          //                   builder: (context) =>
                                          //                       const MySocial(),
                                          //                 ));
                                          //           },
                                          //         )))
                                        ])

                                      //SizedBox(
                                      // width: double.infinity - 40,
                                      // height: 60,
                                      // child: CupertinoButton.filled(

                                      //   child: const Text('View Socials',
                                      //       style: TextStyle(
                                      //           fontSize: 20,
                                      //           fontWeight:
                                      //               FontWeight.bold)),
                                      //   onPressed: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         CupertinoPageRoute(
                                      //           builder: (context) =>
                                      //               const MySocial(),
                                      //         ));
                                      //   },
                                      // ))
                                      : indexItem == 'rishi'
                                          ? SizedBox(
                                              width: double.infinity,
                                              height: 60,
                                              child: Bounceable(
                                                  onTap: () {},
                                                  child: CupertinoButton(
                                                    color:
                                                        const ui.Color.fromARGB(
                                                            255, 88, 101, 242),
                                                    child: const Text(
                                                        'Add on Discord',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    onPressed: () {
                                                      _launchURL(
                                                          "https://discordapp.com/users/669357017307283456");
                                                    },
                                                  )))
                                          : indexItem == 'filmon'
                                              ? SizedBox(
                                                  width: double.infinity,
                                                  height: 60,
                                                  child: Bounceable(
                                                      onTap: () {},
                                                      child: CupertinoButton(
                                                        color: const ui
                                                                .Color.fromARGB(
                                                            255, 255, 252, 0),
                                                        child: const Text(
                                                            'Add on Snapchat',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black)),
                                                        onPressed: () {
                                                          _launchURL(
                                                              "https://www.snapchat.com/add/filmon_king?share_id=MzhGODlBRkYtMEJERC00NjkwLTg4M0MtQUNGNTFERUZDOTFC&locale=en_US");
                                                        },
                                                      )))
                                              : indexItem == 'nick'
                                                  ? SizedBox(
                                                      width: double.infinity,
                                                      height: 60,
                                                      child: Bounceable(
                                                          onTap: () {},
                                                          child:
                                                              CupertinoButton(
                                                            color: const ui
                                                                    .Color.fromARGB(
                                                                255,
                                                                88,
                                                                101,
                                                                242),
                                                            child: const Text(
                                                                'Add on Discord',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            onPressed: () {
                                                              _launchURL(
                                                                  "https://discordapp.com/users/784825209407799297");
                                                            },
                                                          )))
                                                  : indexItem == 'rohan'
                                                      ? Column(children: [
                                                          SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 60,
                                                              child: Bounceable(
                                                                  onTap: () {},
                                                                  child:
                                                                      CupertinoButton(
                                                                    color: const ui
                                                                            .Color.fromARGB(
                                                                        255,
                                                                        88,
                                                                        101,
                                                                        242),
                                                                    child: const Text(
                                                                        'Add on Discord',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    onPressed:
                                                                        () {
                                                                      _launchURL(
                                                                          "https://discordapp.com/users/695271358484971573");
                                                                    },
                                                                  ))),
                                                          const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 8)),
                                                          SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 60,
                                                              child: Bounceable(
                                                                  onTap: () {},
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        44.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                                                              ui.Color.fromARGB(255, 254, 218, 117),
                                                                              ui.Color.fromARGB(255, 250, 126, 30),
                                                                              ui.Color.fromARGB(255, 214, 41, 118),
                                                                              ui.Color.fromARGB(255, 150, 47, 191),
                                                                              ui.Color.fromARGB(255, 79, 91, 213),
                                                                            ])),
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        _launchURL(
                                                                            "https://instagram.com/awesomergs?igshid=YmMyMTA2M2Y=");
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                          primary: Colors
                                                                              .transparent,
                                                                          shadowColor:
                                                                              Colors.transparent),
                                                                      child: const Text(
                                                                          'Follow on Instagram',
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  )))
                                                          //     CupertinoButton(
                                                          //   color: const ui
                                                          //           .Color.fromARGB(
                                                          //       255,
                                                          //       88,
                                                          //       101,
                                                          //       242),
                                                          //   child: const Text(
                                                          //       'Add on Instagram',
                                                          //       style: TextStyle(
                                                          //           fontSize:
                                                          //               20,
                                                          //           fontWeight:
                                                          //               FontWeight.bold)),
                                                          //   onPressed: () {
                                                          //     _launchURL(
                                                          //         "https://www.instagram.com/awesomergs/");
                                                          //   },
                                                          // )
                                                        ])
                                                      : indexItem == 'isaac'
                                                          ? SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 60,
                                                              child: Bounceable(
                                                                  onTap: () {},
                                                                  child:
                                                                      CupertinoButton
                                                                          .filled(
                                                                    child: const Text(
                                                                        'Add on Discord',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    onPressed:
                                                                        () {
                                                                      _launchURL(
                                                                          "https://discordapp.com/users/782137166327054358");
                                                                    },
                                                                  )))
                                                          : Column(children: [
                                                              Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8),
                                                                  child: SizedBox(
                                                                      width: double.infinity,
                                                                      height: 60,
                                                                      child: Bounceable(
                                                                          onTap: () {},
                                                                          child: CupertinoButton.filled(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            child:
                                                                                const Text('Add on Discord', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                            onPressed:
                                                                                () {
                                                                              _launchURL("https://discordapp.com/users/695271358484971573");
                                                                            },
                                                                          )))),
                                                            ]))),
                          //bottom padding below
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          )
                        ])))));
  }
}

class Credits extends StatelessWidget {
  const Credits({super.key});

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
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          automaticallyImplyLeading: true,
          middle: Text('Credits'),
          previousPageTitle: 'Settings',
        ),
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 80),
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 5),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Bounceable(
                          onTap: () {},
                          child: AnimatedTextKit(
                            key: UniqueKey(),
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Flutter     ',
                                textStyle: colorizeTextStyle,
                                colors: colorizeColors,
                              ),
                              ColorizeAnimatedText(
                                'Flutter     ',
                                textStyle: colorizeTextStyle,
                                colors: colorizeColors,
                              ),
                            ],
                            isRepeatingAnimation: true,
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 38, left: 5),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Bounceable(
                          onTap: () {},
                          child: AnimatedTextKit(
                            key: UniqueKey(),
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Dependencies',
                                textStyle: colorizeTextStyle,
                                colors: colorizeColors,
                              ),
                              ColorizeAnimatedText(
                                'Dependencies',
                                textStyle: colorizeTextStyle,
                                colors: colorizeColors,
                              ),
                            ],
                            isRepeatingAnimation: true,
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('Flutter',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context, "https://flutter.dev");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('Random-Words-API',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  'https://github.com/mcnaveen/Random-Words-API');
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('flutter_native_splash',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/flutter_native_splash");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('url_launcher',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/url_launcher");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('rive',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(
                                  context, "https://pub.dev/packages/rive");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('firebase_core',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/firebase_core");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('shared_preferences',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/shared_preferences");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('firebase_messaging',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/firebase_messaging");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('vibration',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/vibration");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('delayed_display',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/delayed_display");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('shake',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(
                                  context, "https://pub.dev/packages/shake");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('flutter_platform_alert',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/flutter_platform_alert");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('dismissible_page',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/dismissible_page");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('flutter_phoenix',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/flutter_phoenix");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('camera',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(
                                  context, "https://pub.dev/packages/camera");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('simple_list_tile',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/simple_list_tile");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('page_transition',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/page_transition");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('flutter_local_notifications',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  "https://pub.dev/packages/flutter_local_notifications");
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('flutter_bounceable',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  'https://pub.dev/packages/flutter_bounceable');
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('swipe_deck',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  'https://pub.dev/packages/swipe_deck');
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('iconforest_arcticons',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  'https://pub.dev/packages/iconforest_arcticons');
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('state_persistence',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  'https://pub.dev/packages/state_persistence');
                            },
                          )))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Bounceable(
                          onTap: () {},
                          child: CupertinoButton.filled(
                            padding: EdgeInsets.zero,
                            child: const Text('video_player',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _launchTAB(context,
                                  'https://pub.dev/packages/video_player');
                            },
                          )))),
            ]));
  }
}

class YourMomJokes extends StatelessWidget {
  const YourMomJokes({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  );
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemStatusBarContrastEnforced: false,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            sized: false,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      middle: Text('your mom jokes'),
                      previousPageTitle: 'Settings',
                      automaticallyImplyLeading: true,
                    ),
                    child: ListView(children: const [
                      CupertinoListTile(
                        title: Text(
                            'ur mom so fat ur dad didnt leave for the milk'),
                      ),
                      CupertinoListTile(
                        title: Text('ur mom 🤣🤢🤣🤢🤢🤣🤣🤣'),
                      ),
                      CupertinoListTile(
                        title: Text(
                            'ur mom so stupid she got an award from "jonas 4"'),
                      ),
                      CupertinoListTile(
                        title: Text('ur mom so dumb that u r a mistake'),
                      ),
                      CupertinoListTile(
                        title: Text(
                            'ur mom so stupid she thought instagram was a weed delivery service'),
                      ),
                    ])))));
  }
}

class EmbarrasingDate extends StatelessWidget {
  const EmbarrasingDate({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  );
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: true,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                ),
                sized: false,
                child: CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      middle: Text('most embarrasing thing on date'),
                      previousPageTitle: 'Settings',
                      automaticallyImplyLeading: true,
                    ),
                    child: ListView(children: [
                      Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: getBoolValuesSF("devModeOn") == false
                              ? const Text(
                                  "Y'all think I'm good enough to get a date 🤣 i dont have a life i spent way too long making stuff like this")
                              : Text(
                                  "Y'all think I'm good enough to get a date 🤣 i dont have a life i spent way too long making stuff like this",
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle))
                    ])))));
  }
}

void _launchTAB(BuildContext context, String first) async {
  try {
    await tab.launch(
      first,
      customTabsOption: CustomTabsOption(
        toolbarColor: Theme.of(context).primaryColor,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        // or user defined animation.
        // animation: const CustoAnimation(
        //   startEnter: 'slide_up',
        //   startExit: 'android:anim/fade_out',
        //   endEnter: 'android:anim/fade_in',
        //   endExit: 'slide_down',
        // ),
        extraCustomTabs: const <String>[
          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
          'org.mozilla.firefox',
          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
          'com.microsoft.emmx',
          'com.samsung.internet'
        ],
      ),
      safariVCOption: SafariViewControllerOption(
        preferredBarTintColor: Theme.of(context).primaryColor,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
    _launchURL(first);
  }
}
