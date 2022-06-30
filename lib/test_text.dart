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

import 'main.dart';

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}

class TestText extends StatelessWidget {
  const TestText({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),
            sized: false,
            child: CupertinoPageScaffold(
                navigationBar: const CupertinoNavigationBar(
                  middle: Text('TestText'),
                  previousPageTitle: 'Home',
                  automaticallyImplyLeading: true,
                ),
                child: ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: getBoolValuesSF() == false
                            ? const Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus id felis id euismod. Nunc non dolor malesuada, finibus quam quis, dictum ligula. Donec tincidunt, dui ac varius commodo, eros tortor pellentesque nulla, sit amet porta lacus odio a sem. Vivamus aliquet ligula at molestie congue. Nulla vel dictum turpis. Morbi consectetur ligula non urna faucibus, ut laoreet purus placerat. Morbi rhoncus porta velit et aliquam. Sed pretium, orci id tincidunt vehicula, metus mauris malesuada nunc, eget consectetur erat risus molestie purus. Fusce convallis diam eu tortor rhoncus gravida. Sed id nunc quis augue vulputate facilisis. Praesent gravida luctus maximus.")
                            : Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus id felis id euismod. Nunc non dolor malesuada, finibus quam quis, dictum ligula. Donec tincidunt, dui ac varius commodo, eros tortor pellentesque nulla, sit amet porta lacus odio a sem. Vivamus aliquet ligula at molestie congue. Nulla vel dictum turpis. Morbi consectetur ligula non urna faucibus, ut laoreet purus placerat. Morbi rhoncus porta velit et aliquam. Sed pretium, orci id tincidunt vehicula, metus mauris malesuada nunc, eget consectetur erat risus molestie purus. Fusce convallis diam eu tortor rhoncus gravida. Sed id nunc quis augue vulputate facilisis. Praesent gravida luctus maximus.",
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle)),
                  ],
                ))));
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
                    child: ListView(children: [
                      const CupertinoListTile(
                        title: Text(
                            'ur mom so fat ur dad didnt leave for the milk'),
                      ),
                      const CupertinoListTile(
                        title: Text('ur mom 🤣🤢🤣🤢🤢🤣🤣🤣'),
                      ),
                      const CupertinoListTile(
                        title: Text(
                            'ur mom so stupid she got an award from "jonas 4"'),
                      ),
                      const CupertinoListTile(
                        title: Text('ur mom so dumb that u r a mistake'),
                      ),
                      const CupertinoListTile(
                        title: Text(
                            'ur mom so stupid she thought instagram was a weed delivery service'),
                      ),
                      CupertinoListTile(
                          subtitle: RichText(
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: TextStyle(
                                fontSize: 11,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              children: const <TextSpan>[
                                TextSpan(text: 'add rohan for suggesting this'),
                              ],
                            ),
                          ),
                          title: const Text('Follow my Xbox Account'),
                          onTap: () => _launchURL(
                              "https://www.snapchat.com/add/awesomergs?share_id=-3bVKPHO7Do&locale=en-US")),
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
