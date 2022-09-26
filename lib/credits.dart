import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tab;
import 'package:url_launcher/url_launcher.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

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
    return Stack(children: [
      SafeArea(
        child: Container(
            color: Colors.black,
            child: ClipRRect(borderRadius: BorderRadius.circular(20))),
      ),
      CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            automaticallyImplyLeading: true,
            middle: Text('Credits'),
            previousPageTitle: 'Settings',
          ),
          child: SafeArea(
              child: Container(
                  color: Colors.black,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 80),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ListView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 80),
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 8, left: 5),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Bounceable(
                                          onTap: () {},
                                          child: AnimatedTextKit(
                                            key: UniqueKey(),
                                            animatedTexts: [
                                              ColorizeAnimatedText(
                                                'Flutter     ',
                                                textStyle: colorizeTextStyle,
                                                colors: colorizeColors,
                                              ),
                                              ColorizeAnimatedText(
                                                'Flutter     ',
                                                textStyle: colorizeTextStyle,
                                                colors: colorizeColors,
                                              ),
                                            ],
                                            isRepeatingAnimation: true,
                                          )))),
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
                                                textStyle: colorizeTextStyle,
                                                colors: colorizeColors,
                                              ),
                                              ColorizeAnimatedText(
                                                'Dependencies',
                                                textStyle: colorizeTextStyle,
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
                                            child: const Text('Flutter',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://flutter.dev");
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
                                            child: const Text(
                                                'Random-Words-API',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  'https://github.com/mcnaveen/Random-Words-API');
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
                                            child: const Text(
                                                'flutter_native_splash',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/flutter_native_splash");
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
                                            child: const Text('url_launcher',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/url_launcher");
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
                                            child: const Text('rive',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/rive");
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
                                            child: const Text('firebase_core',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/firebase_core");
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
                                            child: const Text(
                                                'shared_preferences',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/shared_preferences");
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
                                            child: const Text(
                                                'firebase_messaging',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/firebase_messaging");
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
                                            child: const Text('vibration',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/vibration");
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
                                            child: const Text('delayed_display',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/delayed_display");
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
                                            child: const Text('shake',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/shake");
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
                                            child: const Text(
                                                'flutter_platform_alert',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/flutter_platform_alert");
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
                                            child: const Text(
                                                'dismissible_page',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/dismissible_page");
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
                                            child: const Text('flutter_phoenix',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/flutter_phoenix");
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
                                            child: const Text('camera',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/camera");
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
                                            child: const Text(
                                                'simple_list_tile',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/simple_list_tile");
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
                                            child: const Text('page_transition',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/page_transition");
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
                                            child: const Text(
                                                'flutter_local_notifications',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  "https://pub.dev/packages/flutter_local_notifications");
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
                                            child: const Text(
                                                'flutter_bounceable',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  'https://pub.dev/packages/flutter_bounceable');
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
                                            child: const Text('swipe_deck',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  'https://pub.dev/packages/swipe_deck');
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
                                            child: const Text(
                                                'iconforest_arcticons',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  'https://pub.dev/packages/iconforest_arcticons');
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
                                            child: const Text(
                                                'state_persistence',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  'https://pub.dev/packages/state_persistence');
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
                                            child: const Text('video_player',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () {
                                              _launchTAB(context,
                                                  'https://pub.dev/packages/video_player');
                                            },
                                          )))),
                            ])),
                  ))))
    ]);
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
          'com.samsung.internet'
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

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}
