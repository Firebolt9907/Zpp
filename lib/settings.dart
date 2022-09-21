import 'dart:io';
import 'dart:ui';

import 'package:Zpp/secret_menu.dart';
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
  const MySettings({Key? key, this.darkDynamic, this.lightDynamic})
      : super(key: key);
  final darkDynamic;
  final lightDynamic;
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
            backgroundColor: context.isDarkMode == true
                ? widget.darkDynamic?.background ?? Colors.black
                : widget.lightDynamic?.background ?? Colors.white,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: context.isDarkMode == true
                  ? widget.darkDynamic?.background ?? Colors.black
                  : widget.lightDynamic?.background ?? Colors.white,
              border: Border.all(color: const Color.fromARGB(0, 255, 255, 255)),
              middle: const Text('Settings'),
              previousPageTitle: 'Home',
              automaticallyImplyLeading: true,
            ),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: context.isDarkMode == true
                      ? Brightness.light
                      : Brightness.dark,
                ),
                sized: false,
                child: ListView(
                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Dismissible(
                          resizeDuration: const Duration(milliseconds: 10),
                          direction: DismissDirection.vertical,
                          onDismissed: (dismissed) {
                            if (dismissed == DismissDirection.down) {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => DevConfirm(),
                                  ));
                            } else {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const Credits(),
                                  ));
                            }
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              setState(() {});
                            });
                          },
                          onUpdate: (details) {
                            // setState(() {
                            print(details.progress);
                            // });
                          },
                          key: UniqueKey(),
                          background: Column(children: [
                            Center(
                                child: Text('found me :)',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white))),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Text('Opening Credits'))
                          ]),
                          child: Bounceable(
                              onTap: () {
                                devModeOn == false
                                    ? Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => AboutUs(
                                              darkDynamic: widget.darkDynamic,
                                              lightDynamic:
                                                  widget.lightDynamic),
                                        ))
                                    : Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.leftToRight,
                                            child: AboutUs(
                                                darkDynamic: widget.darkDynamic,
                                                lightDynamic:
                                                    widget.lightDynamic)));
                              },
                              child: Dismissible(
                                  resizeDuration:
                                      const Duration(milliseconds: 10),
                                  direction: DismissDirection.vertical,
                                  onDismissed: (dismissed) {
                                    print(dismissed);
                                    if (dismissed == DismissDirection.down) {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => DevConfirm(),
                                          ));
                                    } else {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const Credits(),
                                          ));
                                    }
                                    Future.delayed(
                                        const Duration(milliseconds: 500), () {
                                      setState(() {});
                                    });
                                  },
                                  onUpdate: (details) {
                                    // setState(() {
                                    print(details.progress);
                                    // });
                                  },
                                  key: UniqueKey(),
                                  background: const Center(
                                      child: Text('found me :)',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white))),
                                  child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              AspectRatio(
                                                  aspectRatio: 4 / 5,
                                                  child: Hero(
                                                      transitionOnUserGestures:
                                                          true,
                                                      tag: 'sus',
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          child: const Image(
                                                              image: AssetImage(
                                                                  'assets/amogus.jpg'),
                                                              fit: BoxFit
                                                                  .cover)))),
                                              ClipRRect(
                                                  // Clip it cleanly.
                                                  child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10, sigmaY: 10),
                                                child: Container(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Text(
                                                      'My Friends',
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          color: context
                                                                      .isDarkMode ==
                                                                  true
                                                              ? widget.darkDynamic
                                                                      ?.primary ??
                                                                  Colors.white
                                                              : widget.lightDynamic
                                                                      ?.primary ??
                                                                  Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                            ],
                                          )))))),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Dismissible(
                              resizeDuration: const Duration(milliseconds: 10),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (dismissed) {
                                devModeOn == false
                                    ? Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => const Credits(),
                                        ))
                                    : Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.leftToRight,
                                            child: const Credits()));
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  setState(() {});
                                });
                              },
                              onUpdate: (details) {
                                // setState(() {
                                print(details.progress);
                                // });
                              },
                              key: UniqueKey(),
                              background: const Center(
                                  child: Text('Open?',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white))),
                              child: Bounceable(
                                  onTap: () {
                                    // CupertinoScaffold.showCupertinoModalBottomSheet(
                                    //   expand: false,
                                    //   bounce: false,
                                    //   useRootNavigator: false,
                                    //   context: context,
                                    //   backgroundColor: Colors.transparent,
                                    //   builder: (context) => const Credits(),
                                    // );
                                  },
                                  child: SimpleListTile(
                                    onTap: () {
                                      devModeOn == false
                                          ? Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    const Credits(),
                                              ))
                                          : Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .leftToRight,
                                                  child: const Credits()));
                                      // CupertinoScaffold
                                      //     .showCupertinoModalBottomSheet(
                                      //   expand: false,
                                      //   bounce: false,
                                      //   useRootNavigator: false,
                                      //   context: context,
                                      //   backgroundColor: Colors.transparent,
                                      //   builder: (context) => const Credits(),
                                      // );
                                    },
                                    title: Text(
                                      'Credits',
                                      style: TextStyle(
                                        color: context.isDarkMode == true
                                            ? widget.darkDynamic?.primary ??
                                                Colors.white
                                            : widget.lightDynamic?.primary ??
                                                Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19.5,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: context.isDarkMode == true
                                          ? widget.darkDynamic?.primary ??
                                              Colors.white
                                          : widget.lightDynamic?.primary ??
                                              Colors.black,
                                    ),
                                    leading: Icon(Icons.camera_alt,
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black,
                                        size: 45),
                                    borderRadius: BorderRadius.circular(15),
                                    tileColor: Colors.grey[300]!,
                                    circleColor: context.isDarkMode == true
                                        ? widget.darkDynamic?.background ??
                                            Colors.black
                                        : widget.lightDynamic?.background ??
                                            Colors.white,
                                    circleDiameter: 80,
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(255, 255, 0, 0),
                                        context.isDarkMode == true
                                            ? widget.darkDynamic?.background ??
                                                Colors.black
                                            : widget.lightDynamic?.background ??
                                                Colors.white,
                                      ],
                                    ),
                                  )))),
                      // Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 5, right: 20, top: 10),
                      //     child: Bounceable(
                      //         onTap: () {
                      //           Future.delayed(
                      //               devModeOn == true
                      //                   ? const Duration(milliseconds: 500)
                      //                   : const Duration(milliseconds: 0), () {
                      //             Navigator.push(
                      //                 context,
                      //                 CupertinoPageRoute(
                      //                   builder: (context) => const MySocial(),
                      //                 ));
                      //           });
                      //         },
                      //         child: SimpleListTile(
                      //           onTap: () {
                      //             Future.delayed(
                      //                 devModeOn == true
                      //                     ? const Duration(milliseconds: 500)
                      //                     : const Duration(milliseconds: 0),
                      //                 () {
                      //               Navigator.push(
                      //                   context,
                      //                   CupertinoPageRoute(
                      //                     builder: (context) =>
                      //                         const MySocial(),
                      //                   ));
                      //             });
                      //           },
                      //           title: Text(
                      //             'My Socials',
                      //             style: TextStyle(
                      //               color: context.isDarkMode == true
                      //                   ? widget.darkDynamic?.primary ??
                      //                       Colors.white
                      //                   : widget.lightDynamic?.primary ??
                      //                       Colors.black,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 20,
                      //             ),
                      //           ),
                      //           trailing: Icon(
                      //             Icons.arrow_forward_ios_rounded,
                      //             color: context.isDarkMode == true
                      //                 ? widget.darkDynamic?.primary ??
                      //                     Colors.white
                      //                 : widget.lightDynamic?.primary ??
                      //                     Colors.black,
                      //           ),
                      //           leading: Icon(
                      //               Platform.isIOS
                      //                   ? Icons.ios_share
                      //                   : Icons.share,
                      //               color: context.isDarkMode == true
                      //                   ? Colors.white
                      //                   : Colors.black,
                      //               size: 45),
                      //           borderRadius: BorderRadius.circular(15),
                      //           tileColor: Colors.grey[300]!,
                      //           circleColor: context.isDarkMode == true
                      //               ? widget.darkDynamic?.background ??
                      //                   Colors.black
                      //               : widget.lightDynamic?.background ??
                      //                   Colors.white,
                      //           circleDiameter: 80,
                      //           gradient: LinearGradient(
                      //             colors: [
                      //               const Color.fromARGB(255, 9, 255, 0),
                      //               context.isDarkMode == true
                      //                   ? widget.darkDynamic?.background ??
                      //                       Colors.black
                      //                   : widget.lightDynamic?.background ??
                      //                       Colors.white,
                      //             ],
                      //           ),
                      //         ))),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 20, top: 10, bottom: 60),
                          child: Bounceable(
                              onTap: () {
                                // _launchURL(
                                //     "mailto:rememberthisrishu@gmail.com?subject=Feedback on Zpp");
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
                                  'Take a Screenshot and Shake Device',
                                  style: TextStyle(
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.transparent),
                                leading: Icon(Icons.feedback_outlined,
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                    size: 45),
                                borderRadius: BorderRadius.circular(15),
                                tileColor: Colors.grey[300]!,
                                circleColor: context.isDarkMode == true
                                    ? widget.darkDynamic?.background ??
                                        Colors.black
                                    : widget.lightDynamic?.background ??
                                        Colors.white,
                                circleDiameter: 80,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color.fromARGB(255, 22, 255, 255),
                                    context.isDarkMode == true
                                        ? widget.darkDynamic?.background ??
                                            Colors.black
                                        : widget.lightDynamic?.background ??
                                            Colors.white,
                                  ],
                                ),
                              ))),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                              'Swipe up on the "My Friends" picture to view Credits',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black)))
                    ]))));
  }
}
