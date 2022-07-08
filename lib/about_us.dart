import 'dart:ui' as ui;
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
import 'package:resize/resize.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secret_menu.dart';
import 'main.dart';

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

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
      statusBarBrightness: ui.Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  var devMode = 0;
  final _offsetToArmed = 75.0;
  Widget build(BuildContext context) {
    // Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: DismissiblePage(
            onDismissed: () {
              _vibrate();
              Navigator.of(context).pop();
            },
            direction: DismissiblePageDismissDirection.down,
            isFullScreen: true,
            maxRadius: 22.0,
            minRadius: 22.0,
            minScale: 0.1,
            child: Scaffold(
                appBar: CupertinoNavigationBar(
                    backgroundColor: Color(0x00000000),
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
                        statusBarIconBrightness: Brightness.dark),
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
                                              DevConfirm()));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    const Hero(
                                        tag: 'sus',
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    ui.Radius.circular(22.0),
                                                bottomRight:
                                                    ui.Radius.circular(22.0)),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/amogus.jpg'),
                                            ))),
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft:
                                                ui.Radius.circular(22.0),
                                            bottomRight:
                                                ui.Radius.circular(22.0)),
                                        child: ClipRRect(
                                            // Clip it cleanly.
                                            child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                            color: Colors.grey.withOpacity(0.1),
                                            alignment: Alignment.center,
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Text(
                                                'Rishu Sharma',
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color:
                                                        CupertinoColors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ))),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                          'dedicaded many weeks to breaking Stack Overflow and his CTRL, C, and V keys',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: context.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          )))),
                              GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        "https://discordapp.com/users/669357017307283456");
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(22.0),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          const Image(
                                              image: AssetImage(
                                                  'assets/rishi.jpg')),
                                          ClipRRect(
                                              borderRadius: const BorderRadius
                                                      .only(
                                                  bottomLeft:
                                                      ui.Radius.circular(22.0),
                                                  bottomRight:
                                                      ui.Radius.circular(22.0)),
                                              child: ClipRRect(
                                                  // Clip it cleanly.
                                                  child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  alignment: Alignment.center,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Text(
                                                      'Rishi Vennapusa',
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          color: CupertinoColors
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                        ],
                                      ))),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                          'did so much work on the app only to not click push changes',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: context.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          )))),
                              GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        "https://discordapp.com/users/784825209407799297");
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(22.0),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          const Image(
                                              image: AssetImage(
                                                  'assets/nick.png')),
                                          ClipRRect(
                                              borderRadius: const BorderRadius
                                                      .only(
                                                  bottomLeft:
                                                      ui.Radius.circular(22.0),
                                                  bottomRight:
                                                      ui.Radius.circular(22.0)),
                                              child: ClipRRect(
                                                  // Clip it cleanly.
                                                  child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  alignment: Alignment.center,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Text(
                                                      'Nick Smith',
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          color: CupertinoColors
                                                              .black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                        ],
                                      ))),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                          'made the universe, forgot to create the app',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: context.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          )))),
                              GestureDetector(
                                  onTap: () {
                                    _launchURL(
                                        "https://www.snapchat.com/add/filmon_king?share_id=MzhGODlBRkYtMEJERC00NjkwLTg4M0MtQUNGNTFERUZDOTFC&locale=en_US");
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(22.0),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          const Image(
                                              image: AssetImage(
                                                  'assets/filmon.jpg')),
                                          ClipRRect(
                                              borderRadius: const BorderRadius
                                                      .only(
                                                  bottomLeft:
                                                      ui.Radius.circular(22.0),
                                                  bottomRight:
                                                      ui.Radius.circular(22.0)),
                                              child: ClipRRect(
                                                  // Clip it cleanly.
                                                  child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  alignment: Alignment.center,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Text(
                                                      'Filmon Negash',
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          color: CupertinoColors
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                        ],
                                      ))),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                          'dedicated his entire summer to play CSGO, aim still garbage',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: context.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          )))),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                YourMomJokes()));
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(22.0),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          const Image(
                                              image: AssetImage(
                                                  'assets/rohan.jpg')),
                                          ClipRRect(
                                              borderRadius: const BorderRadius
                                                      .only(
                                                  bottomLeft:
                                                      ui.Radius.circular(22.0),
                                                  bottomRight:
                                                      ui.Radius.circular(22.0)),
                                              child: ClipRRect(
                                                  // Clip it cleanly.
                                                  child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  alignment: Alignment.center,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Text(
                                                      'Rohan George',
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          color: CupertinoColors
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                        ],
                                      ))),
                              Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                          'told Rishu to make a ur mom jokes page in this',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: context.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          )))),

                              //bottom padding below
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                              )
                            ]))))));
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
      statusBarIconBrightness: Brightness.dark);
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
                statusBarIconBrightness: Brightness.dark),
            sized: false,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(22.0),
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
      statusBarIconBrightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                    systemStatusBarContrastEnforced: true,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark),
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
                          child: getBoolValuesSF() == false
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
