import 'dart:io';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:dynamic_color/dynamic_color.dart';

import 'test_text.dart';
import 'settings.dart';
import 'my_social.dart';
import 'main.dart';

class RefreshHome extends StatefulWidget {
  @override
  RefreshHomeState createState() => RefreshHomeState();
}

class RefreshHomeState extends State<RefreshHome> {
  final _offsetToArmed = 90.0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  bool devModeOn = true;
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Platform.isAndroid ? addBoolToSF(false) : null;
    setState(() {
      devModeOn = (prefs.getBool('devModeOn') ?? true);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                resizeToAvoidBottomInset: false,
                navigationBar: const CupertinoNavigationBar(
                  middle: Text('Home'),
                  automaticallyImplyLeading: true,
                ),
                child: SafeArea(
                    child: CustomRefreshIndicator(
                        onRefresh: () => Future.delayed(
                              const Duration(seconds: 1),
                            ),
                        offsetToArmed: _offsetToArmed,
                        onStateChanged: (IndicatorStateChange change) {
                          if (devModeOn == false) {
                            if (change.didChange(
                                from: IndicatorState.dragging,
                                to: IndicatorState.armed)) {
                              Vibration.vibrate(duration: 5, amplitude: 255);
                            } else if (change.didChange(
                                from: IndicatorState.armed,
                                to: IndicatorState.loading)) {
                              Vibration.vibrate(duration: 10, amplitude: 128);
                            }
                          }
                          //else if (change.didChange(
                          //     from: IndicatorState.armed, to: IndicatorState.loading)) {
                          //   _vibrate();
                          // }
                        },
                        builder: (context, child, controller) =>
                            AnimatedBuilder(
                                animation: controller,
                                child: child,
                                builder: (context, child) {
                                  return Stack(children: <Widget>[
                                    Container(
                                        color: CupertinoTheme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    bottomLeft:
                                                        Radius.circular(22.0),
                                                    bottomRight:
                                                        Radius.circular(22.0)),
                                                child: SizedBox(
                                                    width: double.infinity,
                                                    height: _offsetToArmed *
                                                        controller.value *
                                                        2,
                                                    child: const RiveAnimation
                                                        .asset(
                                                      "assets/falling.riv",
                                                      fit: BoxFit.cover,
                                                    ))))),
                                    Transform.translate(
                                        offset: Offset(
                                            0.0,
                                            _offsetToArmed *
                                                controller.value *
                                                2),
                                        child: child),
                                  ]);
                                }),
                        child: Material(
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              color: CupertinoTheme.of(context)
                                  .scaffoldBackgroundColor,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22.0),
                                  child: ListView(
                                    children: [
                                      CupertinoListTile(
                                          title: const Text("My Social"),
                                          onTap: () => CupertinoScaffold
                                              .showCupertinoModalBottomSheet(
                                                  expand: false,
                                                  context: context,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (context) =>
                                                      MySocial(),
                                                  duration: const Duration(
                                                      milliseconds: 150))),
                                      CupertinoListTile(
                                          title: const Text('Test Text'),
                                          onTap: () => devModeOn == false
                                              ? Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        TestText(),
                                                  ))
                                              : Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: TestText()))),
                                      CupertinoListTile(
                                          title: const Text("Settings"),
                                          onTap: () => devModeOn == false
                                              ? Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        MySettings(),
                                                  ))
                                              : Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: MySettings()))),
                                      CupertinoListTile(
                                          //leading: Icon(),
                                          title: const Text('Send Feedback'),
                                          onTap: () async {
                                            final result =
                                                await FlutterPlatformAlert
                                                    .showAlert(
                                              windowTitle: 'r u sure',
                                              text:
                                                  'this will open the email app bc i cant be bothered to add cloud services to my app',
                                              alertStyle:
                                                  AlertButtonStyle.yesNo,
                                            );
                                            result == AlertButton.yesButton
                                                ? _launchURL(
                                                    "mailto:rememberthisrishu@gmail.com?subject=Feedback on Zpp")
                                                : null;
                                          }),
                                    ],
                                  ))),
                        ))))));
  }
}

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}
