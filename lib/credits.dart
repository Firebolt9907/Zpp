import 'dart:ui';

import 'package:Zpp/main.dart';
import 'package:Zpp/webview.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tab;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sheet/route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Credits extends StatelessWidget {
  const Credits(
      {super.key, this.darkDynamic, this.lightDynamic, this.topPadding});

  final darkDynamic;
  final lightDynamic;
  final topPadding;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
    const colorizeTextStyleBig = TextStyle(
      fontSize: 100.0,
      fontFamily: 'Horizon',
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: false,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
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
                          borderRadius: BorderRadius.circular(18)),
                      height: 5,
                      width: 55))),
          Stack(children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height -
                            topPadding -
                            25,
                        color: Colors.white.withOpacity(0.1)))),
            Padding(
                padding: EdgeInsets.only(top: 00),
                child: SizedBox(
                    height:
                        MediaQuery.of(context).size.height - topPadding - 25,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0)),
                        child: Stack(children: [
                          CupertinoPageScaffold(
                            // navigationBar: CupertinoNavigationBar(
                            //   transitionBetweenRoutes: false,
                            //   automaticallyImplyLeading: false,
                            //   leading: Transform.scale(
                            //       scale: 0.7,
                            //       child: CachedNetworkImage(
                            //         imageUrl:
                            //             "https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png",
                            //         placeholder: (context, url) => Container(),
                            //         errorWidget: (context, url, error) =>
                            //             const SizedBox(
                            //                 height: 300,
                            //                 width: double.infinity,
                            //                 child:
                            //                     Icon(Icons.error, size: 100)),
                            //       )),
                            //   middle: Text('Credits'),
                            //   // trailing: Padding(
                            //   //     padding: EdgeInsets.only(top: 12.5),
                            //   //     child: ClipRect(
                            //   //         child: RotatedBox(
                            //   //             quarterTurns: 1,
                            //   //             child:
                            //   //                 CupertinoNavigationBarBackButton()))),
                            //   previousPageTitle: 'Settings',
                            //   backgroundColor: context.isDarkMode == true
                            //       ? darkDynamic?.background ?? Colors.black
                            //       : lightDynamic?.background ?? Colors.white,
                            //   border: Border.all(
                            //       color:
                            //           const Color.fromARGB(0, 255, 255, 255)),
                            // ),

                            backgroundColor: Colors.transparent,

                            // backgroundColor: context.isDarkMode == true
                            //     ? darkDynamic?.background ?? Colors.black
                            //     : lightDynamic?.background ?? Colors.white,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: ListView(children: [
                                  // CupertinoNavigationBar(
                                  //   automaticallyImplyLeading: false,
                                  //   middle: Text('Credits'),
                                  //   trailing: Padding(
                                  //       padding: EdgeInsets.only(top: 12.5),
                                  //       child: ClipRect(
                                  //           child: RotatedBox(
                                  //               quarterTurns: 1,
                                  //               child:
                                  //                   CupertinoNavigationBarBackButton()))),
                                  //   previousPageTitle: 'Settings',
                                  //   backgroundColor: context.isDarkMode == false
                                  //       ? darkDynamic?.background ?? Colors.black
                                  //       : lightDynamic?.background ?? Colors.white,
                                  //   border: Border.all(
                                  //       color:
                                  //           const Color.fromARGB(0, 255, 255, 255)),
                                  // ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 110, bottom: 50, left: 5),
                                      child: Hero(
                                          transitionOnUserGestures: true,
                                          tag: 'bolt',
                                          child:
                                              Image.asset('assets/bolt.png'))),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 100 +
                                              MediaQuery.of(context)
                                                  .viewPadding
                                                  .bottom,
                                          left: 5),
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Bounceable(
                                              onTap: () {},
                                              child: AnimatedTextKit(
                                                key: UniqueKey(),
                                                animatedTexts: [
                                                  ColorizeAnimatedText(
                                                    'Zpp',
                                                    textAlign: TextAlign.center,
                                                    textStyle:
                                                        colorizeTextStyleBig,
                                                    colors: colorizeColors,
                                                  ),
                                                  ColorizeAnimatedText(
                                                    'Zpp',
                                                    textAlign: TextAlign.center,
                                                    textStyle:
                                                        colorizeTextStyleBig,
                                                    colors: colorizeColors,
                                                  ),
                                                ],
                                                isRepeatingAnimation: true,
                                              )))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15, left: 5),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Bounceable(
                                              onTap: () {},
                                              child: SizedBox(
                                                  width: 225,
                                                  child: CachedNetworkImage(
                                                      imageUrl: context
                                                              .isDarkMode
                                                          ? "https://storage.googleapis.com/cms-storage-bucket/6e19fee6b47b36ca613f.png"
                                                          : "https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png"))))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 38, left: 5),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Bounceable(
                                              onTap: () {},
                                              child: AnimatedTextKit(
                                                key: UniqueKey(),
                                                animatedTexts: [
                                                  ColorizeAnimatedText(
                                                    'Dependencies',
                                                    textStyle:
                                                        colorizeTextStyle,
                                                    colors: colorizeColors,
                                                  ),
                                                  ColorizeAnimatedText(
                                                    'Dependencies',
                                                    textStyle:
                                                        colorizeTextStyle,
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
                                                child: Text('Flutter',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://flutter.dev",
                                                      "Flutter");
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
                                                child: Text('Random-Words-API',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      'https://github.com/mcnaveen/Random-Words-API',
                                                      "Random-Words-API");
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
                                                child: Text(
                                                    'flutter_native_splash',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/flutter_native_splash",
                                                      "flutter_native_splash");
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
                                                child: Text('url_launcher',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/url_launcher",
                                                      "url_launcher");
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
                                                child: Text('rive',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/rive",
                                                      "rive");
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
                                                child: Text('firebase_core',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/firebase_core",
                                                      "firebase_core");
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
                                                child: Text(
                                                    'shared_preferences',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/shared_preferences",
                                                      "shared_preferences");
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
                                                child: Text(
                                                    'firebase_messaging',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/firebase_messaging",
                                                      "firebase_messaging");
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
                                                child: Text('vibration',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/vibration",
                                                      "vibration");
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
                                                child: Text('delayed_display',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/delayed_display",
                                                      "delayed_display");
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
                                                child: Text('shake',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/shake",
                                                      "shake");
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
                                                child: Text('dismissible_page',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/dismissible_page",
                                                      "dismissable_page");
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
                                                child: Text('flutter_phoenix',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/flutter_phoenix",
                                                      "flutter_phoenix");
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
                                                child: Text('camera',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/camera",
                                                      "camera");
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
                                                child: Text('simple_list_tile',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/simple_list_tile",
                                                      "simple_list_tile");
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
                                                child: Text('page_transition',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/page_transition",
                                                      "page_transition");
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
                                                child: Text(
                                                    'flutter_local_notifications',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      "https://pub.dev/packages/flutter_local_notifications",
                                                      "flutter_local_notifications");
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
                                                child: Text(
                                                    'flutter_bounceable',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      'https://pub.dev/packages/flutter_bounceable',
                                                      "flutter_bounceable");
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
                                                child: Text('swipe_deck',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      'https://pub.dev/packages/swipe_deck',
                                                      "swipe_deck");
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
                                                child: Text(
                                                    'iconforest_arcticons',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      'https://pub.dev/packages/iconforest_arcticons',
                                                      "iconforest_arcticons");
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
                                                child: Text('state_persistence',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      'https://pub.dev/packages/state_persistence',
                                                      'state_persistence');
                                                },
                                              )))),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: Bounceable(
                                              onTap: () {},
                                              child: CupertinoButton.filled(
                                                padding: EdgeInsets.zero,
                                                child: Text('video_player',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            context.isDarkMode
                                                                ? Colors.black
                                                                : Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onPressed: () {
                                                  _launchTAB(
                                                      context,
                                                      'https://pub.dev/packages/video_player',
                                                      "video_player");
                                                },
                                              )))),
                                ])),
                          )
                        ])))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 18, 115, 0),
                    child: FittedBox(
                        child: Text("Credits",
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
                                        : Color.fromARGB(255, 240, 240, 240)
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
                                        color: lightDynamic?.primary ??
                                            Color.fromARGB(255, 99, 99, 99),
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
                                              color: lightDynamic?.primary ??
                                                  Color.fromARGB(
                                                      255, 99, 99, 99))))
                                ]))))),
          ])
        ]));
  }
}

void _launchTAB(context, string, preview) {
  // Navigator.push(
  //     context, SheetRoute(builder: (context) => OpenWebView(website: string)));
  CupertinoScaffold.showCupertinoModalBottomSheet(
    expand: true,
    bounce: false,
    context: context,
    backgroundColor: Colors.transparent,
    shadow: BoxShadow(color: Colors.transparent),
    builder: (context) => CupertinoScaffold(
      transitionBackgroundColor: Colors.transparent,
      body: OpenWebView(website: string, preview: preview),
    ),
  );
}

// void _launchTAB(BuildContext context, String first) async {
//   try {
//     await tab.launch(
//       first,
//       customTabsOption: CustomTabsOption(
//         toolbarColor: Theme.of(context).primaryColor,
//         enableDefaultShare: true,
//         enableUrlBarHiding: true,
//         showPageTitle: true,
//         // or user defined animation.
//         // animation: const CustoAnimation(
//         //   startEnter: 'slide_up',
//         //   startExit: 'android:anim/fade_out',
//         //   endEnter: 'android:anim/fade_in',
//         //   endExit: 'slide_down',
//         // ),
//         extraCustomTabs: const <String>[
//           // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
//           'org.mozilla.firefox',
//           // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
//           'com.microsoft.emmx',
//           'com.samsung.internet'
//         ],
//       ),
//       safariVCOption: SafariViewControllerOption(
//         preferredBarTintColor: Theme.of(context).primaryColor,
//         preferredControlTintColor: Colors.white,
//         barCollapsingEnabled: true,
//         entersReaderIfAvailable: false,
//         dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
//       ),
//     );
//   } catch (e) {
//     // An exception is thrown if browser app is not installed on Android device.
//     debugPrint(e.toString());
//     _launchURL(first);
//   }
// }

// _launchURL(var myUrl) async {
//   Uri finalUrl = Uri.parse(myUrl);
//   if (await canLaunchUrl(finalUrl)) {
//     launchUrl(finalUrl, mode: LaunchMode.externalApplication);
//   } else {
//     throw 'Could not launch $myUrl';
//   }
// }
