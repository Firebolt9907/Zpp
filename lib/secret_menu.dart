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
import 'refresh_home.dart';
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
  DevConfirm({Key? key}) : super(key: key);
  final _controller = TextEditingController();
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    // TextEditingController textController = TextEditingController();
    // String displayText = "";
    return ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                    systemStatusBarContrastEnforced: false,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light),
                sized: false,
                child: CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      middle: Text('Slow down there...'),
                      automaticallyImplyLeading: true,
                      previousPageTitle: "About Us",
                    ),
                    backgroundColor: CupertinoColors.systemBackground,
                    child: SafeArea(
                        child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 40, right: 40),
                            child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: GestureDetector(
                                    onTap: () {
                                      _launchURL(
                                          "https://www.youtube.com/watch?v=dQw4w9WgXcQ");
                                    },
                                    child: Hero(
                                        tag: 'sus',
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            child: const Image(
                                              image:
                                                  AssetImage('assets/sus.jpg'),
                                              fit: BoxFit.fitWidth,
                                            )))))),
                        const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("u r going to need a code to do this")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: CupertinoTextField(
                            onChanged: (inputValue) {
                              if (inputValue == "devmodeenable") {
                                Navigator.pop(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.topToBottom,
                                      child: RefreshHome(),
                                    ));
                                addBoolToSF(false);
                                Phoenix.rebirth(context);
                              } else if (inputValue == "date") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => EmbarrasingDate(),
                                    ));
                              } else if (inputValue == "random") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: ((context) => RandomPage())));
                              } else if (inputValue == "devmodedisable") {
                                Navigator.pop(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => RefreshHome(),
                                    ));
                                addBoolToSF(true);
                                Phoenix.rebirth(context);
                              }
                            },
                            autofocus: true,
                            obscureText: true,
                            obscuringCharacter: "ඞ",
                            controller: _controller,
                          ),
                        ),
                      ],
                    ))))));
  }
}
