import 'dart:io';
import 'dart:ui';

import 'package:Zpp/credits.dart';
import 'package:Zpp/secret_menu.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';
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
    var topPadding = MediaQuery.of(context).viewPadding.top;
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
              trailing: Padding(
                  padding: const EdgeInsets.only(top: 0, right: 0),
                  child: Bounceable(
                      scaleFactor: 0.6,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200000),
                              color: const Color.fromARGB(255, 204, 204, 204)
                                  .withOpacity(0.8),
                              boxShadow: [
                                BoxShadow(
                                  color: context.isDarkMode == true
                                      ? const Color.fromARGB(255, 65, 65, 65)
                                          .withOpacity(0.3)
                                      : const Color.fromARGB(255, 204, 204, 204)
                                          .withOpacity(0.6),
                                  spreadRadius: 10,
                                  blurRadius: 7,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Home",
                                    style: TextStyle(
                                      color: widget.lightDynamic?.primary ??
                                          Color.fromARGB(255, 99, 99, 99),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                        size: 25,
                                        color: widget.lightDynamic?.primary ??
                                            Color.fromARGB(255, 99, 99, 99)))
                              ])))),
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
                      Stack(children: [
                        Bounceable(
                            onTap: () {
                              CupertinoScaffold.showCupertinoModalBottomSheet(
                                  shadow: BoxShadow(color: Colors.transparent),
                                  expand: false,
                                  bounce: false,
                                  useRootNavigator: true,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => CupertinoScaffold(
                                      transitionBackgroundColor:
                                          Colors.transparent,
                                      body:
                                          // ? Navigator.push(
                                          //     context,
                                          //     CupertinoPageRoute(
                                          //         builder: (context) =>
                                          CupertinoScaffold(
                                        transitionBackgroundColor:
                                            Colors.transparent,
                                        body: AboutUs(
                                            topPadding: topPadding,
                                            darkDynamic: widget.darkDynamic,
                                            lightDynamic: widget.lightDynamic),
                                      )));
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
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
                                                      tag: 'null',
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          child: const Image(
                                                              height: 400,
                                                              width: 500,
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Hero(
                                                        tag: 'myfriends',
                                                        child: Text(
                                                          'My Friends',
                                                          style: TextStyle(
                                                              fontSize: 40,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ),
                                                ),
                                              )),
                                              Dismissible(
                                                  resizeDuration:
                                                      const Duration(
                                                          milliseconds: 10),
                                                  direction: DismissDirection
                                                      .startToEnd,
                                                  onDismissed: (dismissed) {
                                                    CupertinoScaffold
                                                        .showCupertinoModalBottomSheet(
                                                            shadow: BoxShadow(
                                                                color: Colors
                                                                    .transparent),
                                                            expand: false,
                                                            bounce: false,
                                                            useRootNavigator:
                                                                true,
                                                            context: context,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            builder: (context) =>
                                                                CupertinoScaffold(
                                                                    transitionBackgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    body:
                                                                        // ? Navigator.push(
                                                                        //     context,
                                                                        //     CupertinoPageRoute(
                                                                        //         builder: (context) =>
                                                                        AboutUs(
                                                                      topPadding:
                                                                          topPadding,
                                                                      darkDynamic:
                                                                          widget
                                                                              .darkDynamic,
                                                                      lightDynamic:
                                                                          widget
                                                                              .lightDynamic,
                                                                    )));
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      setState(() {});
                                                    });
                                                  },
                                                  onUpdate: (details) {
                                                    // setState(() {
                                                    // print(details.progress);
                                                    // });
                                                  },
                                                  key: UniqueKey(),
                                                  background: Stack(
                                                    children: [
                                                      ClipRect(
                                                          // Clip it cleanly.
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child: BackdropFilter(
                                                                  filter:
                                                                      ImageFilter.blur(
                                                                          sigmaX:
                                                                              10,
                                                                          sigmaY:
                                                                              10),
                                                                  child: Container(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.1),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: const Padding(
                                                                          padding: EdgeInsets.only(top: 0),
                                                                          child: Align(alignment: Alignment.centerLeft, child: Text('    Open?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)))))))),
                                                    ],
                                                  ),
                                                  child: AspectRatio(
                                                      aspectRatio: 4 / 5,
                                                      child: Container(
                                                          height: 426.3,
                                                          width: 341.0,
                                                          color: Colors
                                                              .transparent))),
                                            ]))))),
                      ]),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Dismissible(
                              resizeDuration: const Duration(milliseconds: 10),
                              direction: DismissDirection.horizontal,
                              onDismissed: (dismissed) {
                                dismissed == DismissDirection.startToEnd
                                    ? {
                                        CupertinoScaffold
                                            .showCupertinoModalBottomSheet(
                                          shadow: BoxShadow(
                                              color: Colors.transparent),
                                          expand: false,
                                          bounce: false,
                                          useRootNavigator: true,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) =>
                                              CupertinoScaffold(
                                                  transitionBackgroundColor:
                                                      Colors.transparent,
                                                  body: Credits(
                                                    topPadding: topPadding,
                                                    darkDynamic:
                                                        widget.darkDynamic,
                                                    lightDynamic:
                                                        widget.lightDynamic,
                                                  )),
                                        ),
                                        showOverlayNotification(
                                            position: NotificationPosition
                                                .bottom, (context) {
                                          return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .viewPadding
                                                          .bottom +
                                                      20),
                                              child: SizedBox(
                                                  width: 300,
                                                  height: 50,
                                                  child: Stack(children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        child: BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 20,
                                                                    sigmaY: 20),
                                                            child: Container(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.1)))),
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              15,
                                                                          right:
                                                                              15),
                                                                      child: FittedBox(
                                                                          fit: BoxFit
                                                                              .fitWidth,
                                                                          child: Text(
                                                                              "Scroll Down to view Credits",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20))))
                                                                ])))
                                                  ])));
                                        },
                                            duration: const Duration(
                                                milliseconds: 1500))
                                      }

                                    // ? Navigator.of(context)
                                    //     .push(SheetRoute<void>(
                                    //     initialExtent: 0.8,
                                    //     stops: <double>[0, 0.75],
                                    //     barrierColor:
                                    //         Colors.black.withOpacity(0.4),
                                    //     builder: (BuildContext context) =>
                                    //         Credits(
                                    //       darkDynamic: widget.darkDynamic,
                                    //       lightDynamic: widget.lightDynamic,
                                    //     ),
                                    //   ))
                                    : showOverlayNotification((context) {
                                        return Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .viewPadding
                                                        .top +
                                                    35),
                                            child: SizedBox(
                                                width: 290,
                                                height: 50,
                                                child: Bounceable(
                                                    onTap: () {
                                                      OverlaySupportEntry.of(
                                                              context)
                                                          ?.dismiss();
                                                      showOverlayNotification(
                                                          (context) {
                                                        return Padding(
                                                            padding: EdgeInsets.only(
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .viewPadding
                                                                        .top +
                                                                    35),
                                                            child: SizedBox(
                                                                width: 290,
                                                                height: 50,
                                                                child: Stack(
                                                                    children: [
                                                                      ClipRRect(
                                                                          borderRadius: BorderRadius.circular(
                                                                              15000),
                                                                          child: BackdropFilter(
                                                                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                                                              child: Container(color: Colors.white.withOpacity(0.1)))),
                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15000),
                                                                              border: Border.all(color: Colors.grey.withOpacity(0.5))),
                                                                          alignment: Alignment.center,
                                                                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                            Text("You found me 😱",
                                                                                style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 18))
                                                                          ]))
                                                                    ])));
                                                      },
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000));
                                                      Navigator.of(context)
                                                          .push(
                                                              SheetRoute<void>(
                                                        stops: <double>[0, 1],
                                                        barrierColor: Colors
                                                            .black
                                                            .withOpacity(0.4),
                                                        builder: (BuildContext
                                                                context) =>
                                                            DevConfirm(
                                                          darkDynamic: widget
                                                              .darkDynamic,
                                                          lightDynamic: widget
                                                              .lightDynamic,
                                                        ),
                                                      ));
                                                    },
                                                    child: Stack(children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      11000),
                                                          child: BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX:
                                                                          20,
                                                                      sigmaY:
                                                                          20),
                                                              child: Container(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.1)))),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15000),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5))),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    "Why did you do that? 🤨📸",
                                                                    style: TextStyle(
                                                                        color: context.isDarkMode
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18))
                                                              ]))
                                                    ]))));
                                      },
                                        duration: Duration(milliseconds: 1500));
                                // : Navigator.push(
                                //     context,
                                //     CupertinoPageRoute(
                                //       builder: (context) => DevConfirm(
                                //         darkDynamic: widget.darkDynamic,
                                //         lightDynamic: widget.lightDynamic,
                                //       ),
                                //     ));
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  setState(() {});
                                });
                              },
                              key: UniqueKey(),
                              background: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('    Open?',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white))),
                              child: Bounceable(
                                  onTap: () {},
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 20),
                                      child: SimpleListTile(
                                        onTap: () {
                                          CupertinoScaffold
                                              .showCupertinoModalBottomSheet(
                                            shadow: BoxShadow(
                                                color: Colors.transparent),
                                            expand: false,
                                            bounce: false,
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) =>
                                                CupertinoScaffold(
                                                    transitionBackgroundColor:
                                                        Colors.transparent,
                                                    body: Credits(
                                                      topPadding: topPadding,
                                                      darkDynamic:
                                                          widget.darkDynamic,
                                                      lightDynamic:
                                                          widget.lightDynamic,
                                                    )),
                                          );
                                          showOverlayNotification(
                                              position: NotificationPosition
                                                  .bottom, (context) {
                                            return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .viewPadding
                                                                .bottom +
                                                            20),
                                                child: SizedBox(
                                                    width: 300,
                                                    height: 50,
                                                    child: Stack(children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          child: BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX:
                                                                          20,
                                                                      sigmaY:
                                                                          20),
                                                              child: Container(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.1)))),
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                15,
                                                                            right:
                                                                                15),
                                                                        child: FittedBox(
                                                                            fit:
                                                                                BoxFit.fitWidth,
                                                                            child: Text("Scroll Down to view Credits", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20))))
                                                                  ])))
                                                    ])));
                                          },
                                              duration: const Duration(
                                                  milliseconds: 1500));
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
                                        title: Hero(
                                            tag: 'credits',
                                            child: Text(
                                              'Credits',
                                              style: TextStyle(
                                                color:
                                                    context.isDarkMode == true
                                                        ? Colors.white
                                                        : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 19.5,
                                              ),
                                            )),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: context.isDarkMode == true
                                              ? widget.darkDynamic?.primary ??
                                                  Colors.white
                                              : widget.lightDynamic?.primary ??
                                                  Colors.black,
                                        ),
                                        leading: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 20, sigmaY: 20),
                                            child: Container(
                                                color: context.isDarkMode
                                                    ? Colors.white
                                                        .withOpacity(0.1)
                                                    : Colors.black
                                                        .withOpacity(0.1),
                                                child: Transform.scale(
                                                    scale: 1.2,
                                                    child: Hero(
                                                        transitionOnUserGestures:
                                                            true,
                                                        key: UniqueKey(),
                                                        tag: 'bolt',
                                                        child: Image.asset(
                                                            'assets/bolt.png'))))),
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
                                            const Color.fromARGB(
                                                255, 255, 0, 0),
                                            context.isDarkMode == true
                                                ? widget.darkDynamic
                                                        ?.background ??
                                                    Colors.black
                                                : widget.lightDynamic
                                                        ?.background ??
                                                    Colors.white,
                                          ],
                                        ),
                                      ))))),

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
                              left: 10, right: 20, top: 10),
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
                                leading: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 20, sigmaY: 20),
                                    child: Container(
                                        color: context.isDarkMode
                                            ? Colors.white.withOpacity(0.1)
                                            : Colors.black.withOpacity(0.1),
                                        child: Icon(Icons.feedback_outlined,
                                            color: context.isDarkMode == true
                                                ? Colors.white
                                                : Colors.black,
                                            size: 45))),
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
                      SafeArea(child: Container())
                    ]))));
  }
}
