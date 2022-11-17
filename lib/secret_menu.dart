import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:Zpp/game/intro.dart';
import 'package:Zpp/webview.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:http/http.dart' as http;

import 'package:Zpp/candidates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';
import 'package:sheet/sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sheet/route.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';
import 'test_text.dart';
import 'random.dart';

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}

class DevConfirm extends StatelessWidget {
  DevConfirm({Key? key, this.darkDynamic, this.lightDynamic}) : super(key: key);
  final darkDynamic;
  final lightDynamic;
  final _controller = TextEditingController();
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  );
  late WebViewController _myController;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 50, bottom: 14),
          child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  height: 5,
                  width: 55))),
      SizedBox(
          height: height - 69,
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              child: CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: const Text('Secret Menu'),
                    automaticallyImplyLeading: false,
                    previousPageTitle: "About Us",
                    backgroundColor: context.isDarkMode == true
                        ? darkDynamic?.background ?? Colors.black
                        : lightDynamic?.background ?? Colors.white,
                    border: Border.all(
                        color: const Color.fromARGB(0, 255, 255, 255)),
                  ),
                  backgroundColor: context.isDarkMode == true
                      ? darkDynamic?.background ?? Colors.black
                      : lightDynamic?.background ?? Colors.white,
                  // navigationBar:
                  //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
                  child: AnnotatedRegion<SystemUiOverlayStyle>(
                      value: const SystemUiOverlayStyle(
                        systemStatusBarContrastEnforced: false,
                        systemNavigationBarColor: Colors.transparent,
                        systemNavigationBarContrastEnforced: false,
                        systemNavigationBarDividerColor: Colors.transparent,
                        systemNavigationBarIconBrightness: Brightness.dark,
                      ),
                      sized: false,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 40, right: 40),
                              child: AspectRatio(
                                  aspectRatio: 19.5 / 12,
                                  child: GestureDetector(
                                      onTap: () {
                                        _launchURL(
                                            "https://www.youtube.com/watch?v=dQw4w9WgXcQ");
                                      },
                                      child: Hero(
                                          transitionOnUserGestures: true,
                                          tag: 'na',
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: const Image(
                                                image: AssetImage(
                                                    'assets/sus.jpg'),
                                                fit: BoxFit.fitWidth,
                                              )))))),
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "u r going to need a code to do this",
                                style: TextStyle(
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: CupertinoTextField(
                              cursorColor: context.isDarkMode == true
                                  ? darkDynamic?.primary ??
                                      CupertinoColors.activeBlue
                                  : lightDynamic?.primary ??
                                      CupertinoColors.activeBlue,
                              onChanged: (inputValue) {
                                if (inputValue == "date") {
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const EmbarrasingDate(),
                                      ));
                                } else if (inputValue == "random") {
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                          builder: ((context) =>
                                              const RandomPage())));
                                } else if (inputValue == "devmode") {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => DevMode(
                                          darkDynamic: darkDynamic,
                                          lightDynamic: lightDynamic,
                                        ),
                                      ));
                                } else if (inputValue == "cands") {
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => CandidatesPage(),
                                      ));
                                } else if (inputValue == "web") {
                                  Navigator.pushReplacement(
                                      context,
                                      SheetRoute<void>(
                                        draggable: true,
                                        builder: (context) => OpenWebView(
                                            website:
                                                "https://whatismybrowser.com"),
                                      ));
                                } else if (inputValue == "game") {
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => GameIntro()));
                                }
                              },
                              autofocus: true,
                              // obscureText: true,
                              // obscuringCharacter: "ඞ",
                              controller: _controller,
                            ),
                          ),
                        ],
                      ))))),
    ]);
  }
}
