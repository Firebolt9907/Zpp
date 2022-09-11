import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:simple_list_tile/simple_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_deck/swipe_deck.dart';

import 'about_us.dart';
import 'main.dart';
import 'my_social.dart';

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}

class MySettings extends StatefulWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  MySettingsState createState() => MySettingsState();
}

class MySettingsState extends State<MySettings> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: false,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  bool devModeOn = true;
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      devModeOn = (prefs.getBool('devModeOn') ?? true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor:
                  context.isDarkMode == true ? Colors.black : Colors.white,
              border: Border.all(color: const Color.fromARGB(0, 255, 255, 255)),
              middle: const Text('Settings'),
              previousPageTitle: 'Home',
              automaticallyImplyLeading: true,
            ),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
                sized: false,
                child: ListView(
                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Bounceable(
                          onTap: () {
                            devModeOn == false
                                ? Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const AboutUs(),
                                    ))
                                : Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        child: const AboutUs()));
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 4 / 5,
                                          child: Hero(
                                              transitionOnUserGestures: true,
                                              tag: 'sus',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: const Image(
                                                      image: AssetImage(
                                                          'assets/amogus.jpg'),
                                                      fit: BoxFit.cover)))),
                                      ClipRRect(
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
                                              'Credits',
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  color: CupertinoColors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ],
                                  )))),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 20, top: 10),
                          child: Bounceable(
                              onTap: () {
                                Future.delayed(
                                    devModeOn == true
                                        ? const Duration(milliseconds: 500)
                                        : const Duration(milliseconds: 0), () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => const MySocial(),
                                      ));
                                });
                              },
                              child: SimpleListTile(
                                onTap: () {
                                  Future.delayed(
                                      devModeOn == true
                                          ? const Duration(milliseconds: 500)
                                          : const Duration(milliseconds: 0),
                                      () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              const MySocial(),
                                        ));
                                  });
                                },
                                title: Text(
                                  'My Socials',
                                  style: TextStyle(
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: context.isDarkMode == true
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                leading: Icon(Icons.share,
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                    size: 45),
                                borderRadius: BorderRadius.circular(15),
                                tileColor: Colors.grey[300]!,
                                circleColor: context.isDarkMode == true
                                    ? Colors.black
                                    : Colors.white,
                                circleDiameter: 80,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color.fromARGB(255, 9, 255, 0),
                                    context.isDarkMode == true
                                        ? Colors.black
                                        : Colors.white
                                  ],
                                ),
                              ))),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 20, top: 10, bottom: 60),
                          child: Bounceable(
                              onTap: () {
                                _launchURL(
                                    "mailto:rememberthisrishu@gmail.com?subject=Feedback on Zpp");
                              },
                              child: SimpleListTile(
                                onTap: () {
                                  _launchURL(
                                      "mailto:rememberthisrishu@gmail.com?subject=Feedback on Zpp");
                                },
                                title: Text(
                                  'Feedback?',
                                  style: TextStyle(
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text(
                                  'Click to send feedback',
                                  style: TextStyle(
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: context.isDarkMode == true
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                leading: Icon(Icons.feedback_outlined,
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                    size: 45),
                                borderRadius: BorderRadius.circular(15),
                                tileColor: Colors.grey[300]!,
                                circleColor: context.isDarkMode == true
                                    ? Colors.black
                                    : Colors.white,
                                circleDiameter: 80,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color.fromARGB(255, 22, 255, 255),
                                    context.isDarkMode == true
                                        ? Colors.black
                                        : Colors.white
                                  ],
                                ),
                              ))),
                    ]))));
  }
}
