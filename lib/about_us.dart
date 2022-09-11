import 'dart:ui' as ui;
import 'dart:ui';
import 'package:Zpp/my_social.dart';
import 'package:flutter/painting.dart';
import 'package:iconforest_arcticons/arcticons.dart';
import 'package:rxdart/rxdart.dart';
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
  const AboutUs({Key? key}) : super(key: key);
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
    systemNavigationBarIconBrightness: Brightness.dark,
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
            backgroundColor:
                context.isDarkMode == true ? Colors.black : Colors.white,
            appBar: CupertinoNavigationBar(
                backgroundColor:
                    context.isDarkMode == true ? Colors.black : Colors.white,
                border: Border.all(color: Colors.transparent),
                previousPageTitle: "Settings",
                middle: const Text("About Us")),
            extendBodyBehindAppBar: true,
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
                        // physics: const NeverScrollableScrollPhysics(),
                        // physics: indexItem == 'amogus'
                        //     ? const ScrollPhysics()
                        //     : const NeverScrollableScrollPhysics(),
                        physics: const ScrollPhysics(),
                        reverse: false,
                        padding: const EdgeInsets.only(top: 120),
                        children: [
                          SwipeDeck(
                            startIndex: 3,
                            cardSpreadInDegrees:
                                5.0, // Change the Spread of Background Cards
                            onSwipeLeft: () {},
                            onSwipeRight: () {},
                            onChange: (index) {
                              setState(() {
                                indexItem = IMAGES[index];
                                print(indexItem);
                              });
                            },
                            widgets: IMAGES
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        if (indexItem == 'amogus') {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          DevConfirm()));
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
                                                    "assets/images/amogus.jpg",
                                                    fit: BoxFit.cover,
                                                  )))
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Image.asset(
                                                "assets/$e.jpg",
                                                fit: BoxFit.cover,
                                              )),
                                    ))
                                .toList(),
                          ),
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
                                                          : Text(
                                                              'waiting for isaac to send desc',
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: context
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ))))),
                          indexItem == 'amogus'
                              ? Align(
                                  alignment: Alignment.topCenter,
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
                                  ))
                              : indexItem == 'rishi'
                                  ? Align(
                                      alignment: Alignment.topCenter,
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
                                      ))
                                  : indexItem == 'filmon'
                                      ? Align(
                                          alignment: Alignment.topCenter,
                                          child: AnimatedTextKit(
                                            key: UniqueKey(),
                                            animatedTexts: [
                                              ColorizeAnimatedText(
                                                'Filmon Negash',
                                                textStyle: colorizeTextStyle,
                                                colors: colorizeColors,
                                              ),
                                              ColorizeAnimatedText(
                                                'Filmon Negash',
                                                textStyle: colorizeTextStyle,
                                                colors: colorizeColors,
                                              ),
                                            ],
                                            isRepeatingAnimation: true,
                                          ))
                                      : indexItem == 'nick'
                                          ? Align(
                                              alignment: Alignment.topCenter,
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
                                              ))
                                          : indexItem == 'rohan'
                                              ? Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: AnimatedTextKit(
                                                    key: UniqueKey(),
                                                    animatedTexts: [
                                                      ColorizeAnimatedText(
                                                        'Rohan George',
                                                        textStyle:
                                                            colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      ),
                                                      ColorizeAnimatedText(
                                                        'Rohan George',
                                                        textStyle:
                                                            colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      ),
                                                    ],
                                                    isRepeatingAnimation: true,
                                                  ))
                                              : Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: AnimatedTextKit(
                                                    key: UniqueKey(),
                                                    animatedTexts: [
                                                      ColorizeAnimatedText(
                                                        'Isaac Durr',
                                                        textStyle:
                                                            colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      ),
                                                      ColorizeAnimatedText(
                                                        'Isaac Durr',
                                                        textStyle:
                                                            colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      ),
                                                    ],
                                                    isRepeatingAnimation: true,
                                                  )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 20, right: 20),
                              child: Align(
                                  alignment: const Alignment(0.0, 1.0),
                                  child: indexItem == 'amogus'
                                      ? Column(children: [
                                          SizedBox(
                                              width: double.infinity,
                                              height: 60,
                                              child: CupertinoButton(
                                                color: const ui.Color.fromARGB(
                                                    255, 88, 101, 242),
                                                child: const Text(
                                                    'Add on Discord',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchURL(
                                                      "https://discordapp.com/users/624016207774875669");
                                                },
                                              )),
                                          const Padding(
                                              padding: EdgeInsets.only(top: 8)),
                                          SizedBox(
                                              width: double.infinity,
                                              height: 60,
                                              child: Container(
                                                height: 44.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    gradient:
                                                        const LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors: [
                                                          ui.Color.fromARGB(255,
                                                              254, 218, 117),
                                                          ui.Color.fromARGB(255,
                                                              250, 126, 30),
                                                          ui.Color.fromARGB(255,
                                                              214, 41, 118),
                                                          ui.Color.fromARGB(255,
                                                              150, 47, 191),
                                                          ui.Color.fromARGB(
                                                              255, 79, 91, 213),
                                                        ])),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _launchURL(
                                                        "https://instagram.com/firebolt_9907?igshid=YmMyMTA2M2Y=");
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors
                                                              .transparent,
                                                          shadowColor: Colors
                                                              .transparent),
                                                  child: const Text(
                                                      'Follow on Instagram',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              )),
                                          const Padding(
                                              padding: EdgeInsets.only(top: 8)),
                                          SizedBox(
                                              width: double.infinity,
                                              height: 60,
                                              child: CupertinoButton(
                                                color: const ui.Color.fromARGB(
                                                    255, 255, 252, 0),
                                                child: const Text(
                                                    'Add on Snapchat',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black)),
                                                onPressed: () {
                                                  _launchURL(
                                                      "https://www.snapchat.com/add/filmon_king?share_id=MzhGODlBRkYtMEJERC00NjkwLTg4M0MtQUNGNTFERUZDOTFC&locale=en_US");
                                                },
                                              )),
                                          const Padding(
                                              padding: EdgeInsets.only(top: 8)),
                                          SizedBox(
                                              width: double.infinity - 40,
                                              height: 60,
                                              child: CupertinoButton.filled(
                                                child: const Text(
                                                    'View Socials',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                        builder: (context) =>
                                                            const MySocial(),
                                                      ));
                                                },
                                              ))
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
                                              child: CupertinoButton(
                                                color: const ui.Color.fromARGB(
                                                    255, 88, 101, 242),
                                                child: const Text(
                                                    'Add on Discord',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchURL(
                                                      "https://discordapp.com/users/669357017307283456");
                                                },
                                              ))
                                          : indexItem == 'filmon'
                                              ? SizedBox(
                                                  width: double.infinity,
                                                  height: 60,
                                                  child: CupertinoButton(
                                                    color:
                                                        const ui.Color.fromARGB(
                                                            255, 255, 252, 0),
                                                    child: const Text(
                                                        'Add on Snapchat',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                    onPressed: () {
                                                      _launchURL(
                                                          "https://www.snapchat.com/add/filmon_king?share_id=MzhGODlBRkYtMEJERC00NjkwLTg4M0MtQUNGNTFERUZDOTFC&locale=en_US");
                                                    },
                                                  ))
                                              : indexItem == 'nick'
                                                  ? SizedBox(
                                                      width: double.infinity,
                                                      height: 60,
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
                                                              "https://discordapp.com/users/784825209407799297");
                                                        },
                                                      ))
                                                  : indexItem == 'rohan'
                                                      ? Column(children: [
                                                          SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 60,
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
                                                                onPressed: () {
                                                                  _launchURL(
                                                                      "https://discordapp.com/users/695271358484971573");
                                                                },
                                                              )),
                                                          const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 8)),
                                                          SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 60,
                                                              child: Container(
                                                                height: 44.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                        gradient: const LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end: Alignment.bottomRight,
                                                                            colors: [
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
                                                                      primary:
                                                                          Colors
                                                                              .transparent,
                                                                      shadowColor:
                                                                          Colors
                                                                              .transparent),
                                                                  child: const Text(
                                                                      'Follow on Instagram',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                              ))
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
                                                      : SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 60,
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
                                                                  "https://discordapp.com/users/782137166327054358");
                                                            },
                                                          )))),
                          //bottom padding below
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          )
                        ])))));
  }
}

class YourMomJokes extends StatelessWidget {
  const YourMomJokes({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
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
    systemNavigationBarIconBrightness: Brightness.dark,
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
