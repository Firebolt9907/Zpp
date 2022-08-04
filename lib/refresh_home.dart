import 'dart:io';
import 'package:Zpp/candidates.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart' as rive;
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:camera/camera.dart';
import 'package:simple_list_tile/simple_list_tile.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:dynamic_color/dynamic_color.dart';

import 'about_us.dart';
import 'test_text.dart';
import 'settings.dart';
import 'my_social.dart';
import 'main.dart';
import 'candidates.dart';

class RefreshHome extends StatefulWidget {
  const RefreshHome({Key? key}) : super(key: key);
  @override
  RefreshHomeState createState() => RefreshHomeState();
}

class RefreshHomeState extends State<RefreshHome> {
  final _offsetToArmed = 90.0;
  late CameraController controller;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _loadCounter();
    // controller.initialize();
  }

  bool devModeOn = true;
  bool spam = true;
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Platform.isAndroid ? addBoolToSF('devModeOn', false) : null;
    setState(() {
      devModeOn = (prefs.getBool('devModeOn') ?? true);
      spam = (prefs.getBool('spam') ?? true);
    });
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/wow.png'), context);
    WidgetsFlutterBinding.ensureInitialized();

    GoToTestText() {
      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TestText(),
          ));
    }

    // spam == true
    //     ? {
    //         WidgetsFlutterBinding.ensureInitialized(),
    //         Navigator.push(
    //             context,
    //             CupertinoPageRoute(
    //               builder: (context) => AboutUs(),
    //             ))
    //       }
    //     : null;
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Home'),
          automaticallyImplyLeading: true,
        ),
        backgroundColor:
            context.isDarkMode == true ? Colors.black : Colors.white,
        // navigationBar:
        //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemStatusBarContrastEnforced: false,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            sized: false,
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
                    builder: (context, child, controller) => AnimatedBuilder(
                        animation: controller,
                        child: child,
                        builder: (context, child) {
                          return Stack(children: <Widget>[
                            Container(
                                color: context.isDarkMode == true
                                    ? Colors.black
                                    : Colors.white,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 0.0),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0)),
                                        child: SizedBox(
                                            width: double.infinity,
                                            height: _offsetToArmed *
                                                controller.value *
                                                2,
                                            child:
                                                const rive.RiveAnimation.asset(
                                              "assets/falling.riv",
                                              fit: BoxFit.cover,
                                            ))))),
                            Transform.translate(
                                offset: Offset(
                                    0.0, _offsetToArmed * controller.value * 2),
                                child: child),
                          ]);
                        }),
                    child: Material(
                      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: ListView(
                                children: [
                                  CupertinoListTile(
                                      title: const Text("Election Candidates"),
                                      onTap: () => devModeOn == false
                                          ? Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    CandidatesPage(),
                                              ))
                                          : Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  curve: Curves.easeOutExpo,
                                                  child: MySettings()))),
                                  CupertinoListTile(
                                      title: const Text("My Social"),
                                      onTap: () {
                                        Future.delayed(
                                            devModeOn == true
                                                ? const Duration(
                                                    milliseconds: 500)
                                                : const Duration(
                                                    milliseconds: 0), () {
                                          CupertinoScaffold
                                              .showCupertinoModalBottomSheet(
                                                  expand: false,
                                                  context: context,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (context) =>
                                                      MySocial(),
                                                  duration: const Duration(
                                                      milliseconds: 150));
                                        });
                                      }),
                                  CupertinoListTile(
                                      title: const Text(
                                          "See Yourself in 200 years"),
                                      onTap: () {
                                        Future.delayed(
                                            devModeOn
                                                ? const Duration(
                                                    milliseconds: 2500)
                                                : const Duration(
                                                    milliseconds: 0), () {
                                          CupertinoScaffold
                                              .showCupertinoModalBottomSheet(
                                                  expand: false,
                                                  bounce: false,
                                                  useRootNavigator: false,
                                                  context: context,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (context) =>
                                                      const FutureCamera(),
                                                  duration: const Duration(
                                                      milliseconds: 150));
                                        });
                                      }),
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
                                                  curve: Curves.easeOutExpo,
                                                  child: MySettings()))),
                                  SimpleListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                CandidatesPage(),
                                          ));
                                    },
                                    title: Text(
                                      'Election Candidates',
                                      style: TextStyle(
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: context.isDarkMode == true
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    leading: const Icon(
                                      Icons.phone_android,
                                      color: Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    tileColor: Colors.grey[300]!,
                                    circleColor: Colors.grey[100]!,
                                    circleDiameter: 80,
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(255, 0, 81, 255),
                                        context.isDarkMode == true
                                            ? Colors.black
                                            : Colors.white
                                      ],
                                    ),
                                  ),
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
                                          alertStyle: AlertButtonStyle.yesNo,
                                        );
                                        result == AlertButton.yesButton
                                            ? _launchURL(
                                                "mailto:rememberthisrishu@gmail.com?subject=Feedback on Zpp")
                                            : null;
                                      }),
                                ],
                              ))),
                    )))));
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
