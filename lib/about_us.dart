import 'dart:ui' as ui;
import 'dart:ui';
import 'package:Zpp/test.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tab;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:swipe_deck/swipe_deck.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

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


class AboutUs extends StatefulWidget {
  const AboutUs(
      {Key? key, this.darkDynamic, this.lightDynamic, this.topPadding})
      : super(key: key);
  final darkDynamic;
  final lightDynamic;
  final topPadding;

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
  bool hint = true;

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: false,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarColor: const ui.Color.fromARGB(0, 0, 0, 0),
          systemNavigationBarIconBrightness:
              context.isDarkMode == true ? Brightness.light : Brightness.dark,
        ),
        sized: false,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 10),
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      height: 5,
                      width: 55))),
          Stack(children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height -
                            widget.topPadding -
                            25,
                        color: Colors.white.withOpacity(0.1)))),
            Padding(
                padding: const EdgeInsets.only(top: 0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        widget.topPadding -
                        25,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0),
                        ),
                        child: CupertinoPageScaffold(
                            resizeToAvoidBottomInset: true,
                            backgroundColor: Colors.transparent,
                            // backgroundColor: context.isDarkMode == true
                            //     ? widget.darkDynamic?.background ?? Colors.black
                            //     : widget.lightDynamic?.background ??
                            //         Colors.white,
                            // navigationBar: CupertinoNavigationBar(
                            //   transitionBetweenRoutes: false,
                            //   backgroundColor: context.isDarkMode == true
                            //       ? widget.darkDynamic?.background ??
                            //           Colors.black
                            //       : widget.lightDynamic?.background ??
                            //           Colors.white,
                            //   border: Border.all(color: Colors.transparent),
                            //   previousPageTitle: "Settings",
                            //   middle: const Text("My Friends"),
                            // ),

                            // extendBodyBehindAppBar: true,
                            child: /*CupertinoPageScaffold(
                    backgroundColor: context.isDarkMode == true
                        ? widget.darkDynamic?.background ?? Colors.black
                        : widget.lightDynamic?.background ?? Colors.white,
                    resizeToAvoidBottomInset: false,
                    child: */
                                ListView(
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
                                        cardSpreadInDegrees: 5.0,
                                        // Change the Spread of Background Cards
                                        onSwipeLeft: () {},
                                        onSwipeRight: () {},
                                        onChange: (index) {
                                          setState(() {
                                            hint = false;
                                            indexItem = IMAGES[index];
                                          });
                                        },
                                        widgets: IMAGES
                                            .map((e) => Bounceable(
                                                  onTap: () {
                                                    if (indexItem == 'amogus') {
                                                      _launchURL(
                                                          'https://www.youtube.com/watch?v=LLFhKaqnWwk');
                                                    } else if (indexItem ==
                                                        'rishi') {
                                                      _launchURL(
                                                          "https://discordapp.com/users/669357017307283456");
                                                    } else if (indexItem ==
                                                        'nick') {
                                                      _launchURL(
                                                          "https://discordapp.com/users/784825209407799297");
                                                    } else if (indexItem ==
                                                        'filmon') {
                                                      _launchURL(
                                                          "https://www.snapchat.com/add/filmon_king?share_id=MzhGODlBRkYtMEJERC00NjkwLTg4M0MtQUNGNTFERUZDOTFC&locale=en_US");
                                                    } else if (indexItem ==
                                                        'isaac') {
                                                      _launchURL(
                                                          "https://discordapp.com/users/782137166327054358");
                                                    } else if (indexItem ==
                                                        'rohan') {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     CupertinoPageRoute(
                                                      //         builder: (BuildContext
                                                      //                 context) =>
                                                      //             YoMomma(
                                                      //               darkDynamic: widget
                                                      //                   .darkDynamic,
                                                      //               lightDynamic: widget
                                                      //                   .lightDynamic,
                                                      //             )));
                                                      CupertinoScaffold
                                                          .showCupertinoModalBottomSheet(
                                                        shadow: const BoxShadow(
                                                            color: Colors
                                                                .transparent),
                                                        expand: false,
                                                        bounce: false,
                                                        useRootNavigator: true,
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        builder: (context) =>
                                                            YoMomma(
                                                          darkDynamic: widget
                                                              .darkDynamic,
                                                          lightDynamic: widget
                                                              .lightDynamic,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: e == 'amogus'
                                                      ? Hero(
                                                          tag: 'sus',
                                                          transitionOnUserGestures:
                                                              indexItem ==
                                                                      'amogus'
                                                                  ? true
                                                                  : false,
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              child:
                                                                  Image.asset(
                                                                "assets/amogus.jpg",
                                                                fit: BoxFit
                                                                    .cover,
                                                              )))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: Image.asset(
                                                            "assets/$e.jpg",
                                                            fit: BoxFit.cover,
                                                          )),
                                                ))
                                            .toList(),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 10),
                                      child: Text(
                                          hint
                                              ? 'Try swiping left and right on the picture!'
                                              : '',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: ui.Color.fromARGB(
                                                  174, 255, 255, 255)))),

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
                                                    textStyle:
                                                        colorizeTextStyle,
                                                    colors: colorizeColors,
                                                  ),
                                                  ColorizeAnimatedText(
                                                    'Rishu Sharma',
                                                    textStyle:
                                                        colorizeTextStyle,
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
                                                        textStyle:
                                                            colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      ),
                                                      ColorizeAnimatedText(
                                                        'Rishi Vennapusa',
                                                        textStyle:
                                                            colorizeTextStyle,
                                                        colors: colorizeColors,
                                                      ),
                                                    ],
                                                    isRepeatingAnimation: true,
                                                  )))
                                          : indexItem == 'filmon'
                                              ? Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Bounceable(
                                                      onTap: () {},
                                                      child: AnimatedTextKit(
                                                        key: UniqueKey(),
                                                        animatedTexts: [
                                                          ColorizeAnimatedText(
                                                            'Filmon Negash',
                                                            textStyle:
                                                                colorizeTextStyle,
                                                            colors:
                                                                colorizeColors,
                                                          ),
                                                          ColorizeAnimatedText(
                                                            'Filmon Negash',
                                                            textStyle:
                                                                colorizeTextStyle,
                                                            colors:
                                                                colorizeColors,
                                                          ),
                                                        ],
                                                        isRepeatingAnimation:
                                                            true,
                                                      )))
                                              : indexItem == 'nick'
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
                                                                'Nick Smith',
                                                                textStyle:
                                                                    colorizeTextStyle,
                                                                colors:
                                                                    colorizeColors,
                                                              ),
                                                              ColorizeAnimatedText(
                                                                'Nick Smith',
                                                                textStyle:
                                                                    colorizeTextStyle,
                                                                colors:
                                                                    colorizeColors,
                                                              ),
                                                            ],
                                                            isRepeatingAnimation:
                                                                true,
                                                          )))
                                                  : indexItem == 'rohan'
                                                      ? Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Bounceable(
                                                              onTap: () {},
                                                              child:
                                                                  AnimatedTextKit(
                                                                key:
                                                                    UniqueKey(),
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
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Bounceable(
                                                                  onTap: () {},
                                                                  child:
                                                                      AnimatedTextKit(
                                                                    key:
                                                                        UniqueKey(),
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
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Bounceable(
                                                                  onTap: () {},
                                                                  child:
                                                                      AnimatedTextKit(
                                                                    key:
                                                                        UniqueKey(),
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
                                  SizedBox(
                                      height: 100,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20,
                                              bottom: 0,
                                              left: 20,
                                              right: 20),
                                          child: Align(
                                              alignment: Alignment.topCenter,
                                              child: indexItem == 'amogus'
                                                  ? Text(
                                                      'dedicaded many weeks to breaking Stack Overflow and his CTRL, C, and V keys',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                      ))
                                                  : indexItem == 'rishi'
                                                      ? Text(
                                                          'did so much work on the app only to not click push changes',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ))
                                                      : indexItem == 'filmon'
                                                          ? Text(
                                                              'dedicated his entire summer to play CSGO, aim still garbage',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: context
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ))
                                                          : indexItem == 'nick'
                                                              ? Text(
                                                                  'made the universe, forgot to create the app',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                              : indexItem ==
                                                                      'rohan'
                                                                  ? Text(
                                                                      'told Rishu to make a ur mom jokes page in this',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20.0,
                                                                        color: context.isDarkMode
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                      ))
                                                                  : indexItem ==
                                                                          'isaac'
                                                                      ? Text(
                                                                          "that one 6'9'' person",
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            color: context.isDarkMode
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                          ))
                                                                      : Text(
                                                                          'waiting for isaac to send desc',
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20.0,
                                                                            color: context.isDarkMode
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                          ))))),
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
                                                      child: Bounceable(
                                                          onTap: () {},
                                                          child:
                                                              CupertinoButton(
                                                            pressedOpacity: 1.0,
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
                                                                  "https://discordapp.com/users/624016207774875669");
                                                            },
                                                          ))),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8)),
                                                  SizedBox(
                                                      width: double.infinity,
                                                      height: 60,
                                                      child: Bounceable(
                                                          onTap: () {
                                                            _launchURL(
                                                                "https://instagram.com/firebolt_9907?igshid=YmMyMTA2M2Y=");
                                                          },
                                                          child: Container(
                                                            height: 44.0,
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                            child: const Center(
                                                                child: Text(
                                                                    'Follow on Instagram',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white))),
                                                          ))),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8)),
                                                  SizedBox(
                                                      width: double.infinity,
                                                      height: 60,
                                                      child: Bounceable(
                                                          onTap: () {},
                                                          child:
                                                              CupertinoButton(
                                                            pressedOpacity: 1.0,
                                                            color: const ui
                                                                    .Color.fromARGB(
                                                                255,
                                                                255,
                                                                252,
                                                                0),
                                                            child: const Text(
                                                                'Add on Snapchat',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black)),
                                                            onPressed: () {
                                                              _launchURL(
                                                                  "https://www.snapchat.com/add/firebolt_9907?share_id=6bLdC4GNgg8&locale=en-US");
                                                            },
                                                          ))),

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
                                                          child:
                                                              CupertinoButton(
                                                            pressedOpacity: 1.0,
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
                                                                  "https://discordapp.com/users/669357017307283456");
                                                            },
                                                          )))
                                                  : indexItem == 'filmon'
                                                      ? SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 60,
                                                          child: Bounceable(
                                                              onTap: () {},
                                                              child:
                                                                  CupertinoButton(
                                                                pressedOpacity:
                                                                    1.0,
                                                                color: const ui
                                                                        .Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    252,
                                                                    0),
                                                                child: const Text(
                                                                    'Add on Snapchat',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
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
                                                          ? Column(children: [
                                                              SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 60,
                                                                  child:
                                                                      Bounceable(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              CupertinoButton(
                                                                            pressedOpacity:
                                                                                1.0,
                                                                            color: const ui.Color.fromARGB(
                                                                                255,
                                                                                88,
                                                                                101,
                                                                                242),
                                                                            child:
                                                                                const Text('Add on Discord', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                            onPressed:
                                                                                () {
                                                                              _launchURL("https://discordapp.com/users/784825209407799297");
                                                                            },
                                                                          ))),
                                                              const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8)),
                                                              SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 60,
                                                                  child:
                                                                      Bounceable(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              CupertinoButton(
                                                                            pressedOpacity:
                                                                                1.0,
                                                                            color: const ui.Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                252,
                                                                                0),
                                                                            child:
                                                                                const Text('Add on Snapchat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                                                                            onPressed:
                                                                                () {
                                                                              _launchURL("https://www.snapchat.com/add/rememberthisns?share_id=YFiKVgK_WrM&locale=en-US");
                                                                            },
                                                                          )))
                                                            ])
                                                          : indexItem == 'rohan'
                                                              ? Column(
                                                                  children: [
                                                                      SizedBox(
                                                                          width: double
                                                                              .infinity,
                                                                          height:
                                                                              60,
                                                                          child: Bounceable(
                                                                              onTap: () {},
                                                                              child: CupertinoButton(
                                                                                pressedOpacity: 0.0,
                                                                                color: const ui.Color.fromARGB(255, 88, 101, 242),
                                                                                child: const Text('Add on Discord', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                                onPressed: () {
                                                                                  _launchURL("https://discordapp.com/users/695271358484971573");
                                                                                },
                                                                              ))),
                                                                      const Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 8)),
                                                                      SizedBox(
                                                                          width: double
                                                                              .infinity,
                                                                          height:
                                                                              60,
                                                                          child: Bounceable(
                                                                              onTap: () {
                                                                                _launchURL("https://instagram.com/awesomergs?igshid=YmMyMTA2M2Y=");
                                                                              },
                                                                              child: Container(
                                                                                height: 44.0,
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                                                                      ui.Color.fromARGB(255, 254, 218, 117),
                                                                                      ui.Color.fromARGB(255, 250, 126, 30),
                                                                                      ui.Color.fromARGB(255, 214, 41, 118),
                                                                                      ui.Color.fromARGB(255, 150, 47, 191),
                                                                                      ui.Color.fromARGB(255, 79, 91, 213),
                                                                                    ])),
                                                                                child: const Center(child: Text('Follow on Instagram', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                                                                              )))
                                                                      //     CupertinoButton(
                                                                      //  pressedOpacity: 1.0,
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
                                                              : indexItem ==
                                                                      'isaac'
                                                                  ? SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          60,
                                                                      child: Bounceable(
                                                                          onTap: () {},
                                                                          child: CupertinoButton(
                                                                            pressedOpacity:
                                                                                0.0,
                                                                            color: const ui.Color.fromARGB(
                                                                                255,
                                                                                88,
                                                                                101,
                                                                                242),
                                                                            child:
                                                                                const Text('Add on Discord', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                            onPressed:
                                                                                () {
                                                                              _launchURL("https://discordapp.com/users/782137166327054358");
                                                                            },
                                                                          )))
                                                                  : Column(children: [
                                                                      Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(bottom: 8),
                                                                          child: SizedBox(
                                                                              width: double.infinity,
                                                                              height: 60,
                                                                              child: Bounceable(
                                                                                  onTap: () {},
                                                                                  child: CupertinoButton(
                                                                                    pressedOpacity: 0.0,
                                                                                    color: const ui.Color.fromARGB(255, 88, 101, 242),
                                                                                    padding: EdgeInsets.zero,
                                                                                    child: const Text('Add on Discord', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                                                    onPressed: () {
                                                                                      _launchURL("https://discordapp.com/users/695271358484971573");
                                                                                    },
                                                                                  )))),
                                                                    ]))),
                                  //bottom padding below
                                  SafeArea(child: Container())
                                ]))))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 18, 115, 0),
                    child: FittedBox(
                        child: Text("My Friends",
                            style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))))),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: Bounceable(
                        scaleFactor: 0.6,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: 125,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200000),
                                color: const Color.fromARGB(255, 204, 204, 204)
                                    .withOpacity(0.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: context.isDarkMode == true
                                        ? const Color.fromARGB(255, 65, 65, 65)
                                            .withOpacity(0.3)
                                        : const Color.fromARGB(255, 240, 240, 240)
                                            .withOpacity(0.6),
                                    spreadRadius: 10,
                                    blurRadius: 7,
                                    // changes position of shadow
                                  ),
                                ]),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Settings",
                                      style: TextStyle(
                                        color: widget.lightDynamic?.primary ??
                                            const Color.fromARGB(255, 99, 99, 99),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      )),
                                  SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: RotatedBox(
                                          quarterTurns: 1,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 25,
                                              color: widget
                                                      .lightDynamic?.primary ??
                                                  const Color.fromARGB(
                                                      255, 99, 99, 99))))
                                ]))))),
          ]),
        ])) /*)*/;
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
          'com.sec.android.app.sbrowser',
          'org.bromite.bromite'
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
