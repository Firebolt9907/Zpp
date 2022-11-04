// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:Zpp/candidates.dart';
import 'package:Zpp/coin_flip.dart';
import 'package:Zpp/coin_flip_3p.dart';
import 'package:Zpp/coin_flip_5p.dart';
import 'package:Zpp/coin_flip_6p.dart';
import 'package:Zpp/coin_flip_7p.dart';
import 'package:Zpp/coin_flip_8p.dart';
import 'package:Zpp/random-word.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
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
import 'package:dynamic_color/dynamic_color.dart';

// import 'package:overlay_support/overlay_support.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:dynamic_color/dynamic_color.dart';

import 'about_us.dart';
import 'coin_flip_4p.dart';
import 'test_text.dart';
import 'settings.dart';
import 'my_social.dart';
import 'main.dart';
import 'candidates.dart';
import 'secret_menu.dart';

class RefreshHome extends StatefulWidget {
  const RefreshHome({Key? key, this.darkDynamic, this.lightDynamic})
      : super(key: key);
  final darkDynamic;
  final lightDynamic;

  @override
  RefreshHomeState createState() => RefreshHomeState();
}

class RefreshHomeState extends State<RefreshHome> {
  final _offsetToArmed = 90.0;
  late CameraController controller;
  late List<CameraDescription> _cameras;

  // final darkDynamic;
  // final lightDynamic;

  @override
  void initState() {
    super.initState();
    _loadCounter();
    // controller.initialize();
  }

  double left = 0;
  bool devModeOn = true;
  bool spam = true;
  double coinFlip = 2;
  double value = 2.0;

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Platform.isAndroid ? addBoolToSF('devModeOn', false) : null;
    setState(() {
      devModeOn = (prefs.getBool('devModeOn') ?? true);
      spam = (prefs.getBool('spam') ?? true);
    });
  }

  var randInt = Random().nextInt(2);
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/wow.png'), context);
    WidgetsFlutterBinding.ensureInitialized();

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
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return CupertinoPageScaffold(
          resizeToAvoidBottomInset: false,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: context.isDarkMode == true
                ? darkDynamic?.background ?? Colors.black
                : lightDynamic?.background ?? Colors.white,
            border: Border.all(color: Colors.transparent),
            middle: const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text('Zpp')),
            automaticallyImplyLeading: true,
          ),
          backgroundColor: context.isDarkMode == true
              ? darkDynamic?.background ?? Colors.black
              : lightDynamic?.primary ?? Colors.white,
          // navigationBar:
          //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                // systemStatusBarContrastEnforced: false,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarContrastEnforced: false,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: context.isDarkMode == true
                    ? Brightness.light
                    : Brightness.dark,
              ),
              sized: false,
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
                                ? darkDynamic?.background ?? Colors.black
                                : lightDynamic?.background ?? Colors.white,
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
                                        child: const rive.RiveAnimation.asset(
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
                    color: context.isDarkMode == true
                        ? darkDynamic?.background ?? Colors.black
                        : lightDynamic?.background ?? Colors.white,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ListView(children: [
                          Stack(
                            // padding: const EdgeInsets.only(bottom: 0),
                            children: [
                              DelayedDisplay(
                                  delay: const Duration(milliseconds: 0),
                                  child: Dismissible(
                                      resizeDuration:
                                          const Duration(milliseconds: 10),
                                      direction: DismissDirection.none,
                                      onDismissed: (dismissed) {
                                        Platform.isMacOS
                                            ? null
                                            : Platform.isWindows
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10);
                                        devModeOn == false
                                            ? Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) => coinFlip ==
                                                          2.0
                                                      ? CoinFlip2p(
                                                          devModeOn: devModeOn,
                                                        )
                                                      : coinFlip == 3.0
                                                          ? CoinFlip3p(
                                                              devModeOn:
                                                                  devModeOn,
                                                            )
                                                          : coinFlip == 4.0
                                                              ? CoinFlip4p(
                                                                  devModeOn:
                                                                      devModeOn,
                                                                )
                                                              : coinFlip == 5.0
                                                                  ? CoinFlip5p(
                                                                      devModeOn:
                                                                          devModeOn,
                                                                    )
                                                                  : coinFlip ==
                                                                          6.0
                                                                      ? CoinFlip6p(
                                                                          devModeOn:
                                                                              devModeOn,
                                                                        )
                                                                      : coinFlip ==
                                                                              7.0
                                                                          ? CoinFlip7p(
                                                                              devModeOn: devModeOn,
                                                                            )
                                                                          : CoinFlip8p(
                                                                              devModeOn: devModeOn,
                                                                            ),
                                                ))
                                            : Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    curve: Curves.easeOutExpo,
                                                    child: coinFlip == 2.0
                                                        ? const CoinFlip2p()
                                                        : coinFlip == 3.0
                                                            ? const CoinFlip3p()
                                                            : coinFlip == 4.0
                                                                ? const CoinFlip4p()
                                                                : coinFlip ==
                                                                        5.0
                                                                    ? const CoinFlip5p()
                                                                    : coinFlip ==
                                                                            6.0
                                                                        ? const CoinFlip6p()
                                                                        : coinFlip ==
                                                                                7.0
                                                                            ? const CoinFlip7p()
                                                                            : const CoinFlip8p()));
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          setState(() {});
                                        });
                                      },
                                      onUpdate: (details) {
                                        // setState(() {
                                        // });
                                      },
                                      key: UniqueKey(),
                                      background: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Open?',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: context.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black))),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20,
                                              left: 10,
                                              right: 20,
                                              bottom: 0),
                                          child: Bounceable(
                                              onTap: () {
                                                Platform.isMacOS
                                                    ? null
                                                    : Platform.isWindows
                                                        ? null
                                                        : Vibration.vibrate(
                                                            duration: 10);

                                                devModeOn == false
                                                    ? Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                          builder: (context) => coinFlip ==
                                                                  2.0
                                                              ? CoinFlip2p(
                                                                  devModeOn:
                                                                      devModeOn,
                                                                )
                                                              : coinFlip == 3.0
                                                                  ? CoinFlip3p(
                                                                      devModeOn:
                                                                          devModeOn,
                                                                    )
                                                                  : coinFlip ==
                                                                          4.0
                                                                      ? CoinFlip4p(
                                                                          devModeOn:
                                                                              devModeOn,
                                                                        )
                                                                      : coinFlip ==
                                                                              5.0
                                                                          ? CoinFlip5p(
                                                                              devModeOn: devModeOn,
                                                                            )
                                                                          : coinFlip == 6.0
                                                                              ? CoinFlip6p(
                                                                                  devModeOn: devModeOn,
                                                                                )
                                                                              : coinFlip == 7.0
                                                                                  ? CoinFlip7p(
                                                                                      devModeOn: devModeOn,
                                                                                    )
                                                                                  : CoinFlip8p(
                                                                                      devModeOn: devModeOn,
                                                                                    ),
                                                        ))
                                                    : Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .rightToLeft,
                                                            curve: Curves
                                                                .easeOutExpo,
                                                            child: coinFlip ==
                                                                    2.0
                                                                ? const CoinFlip2p()
                                                                : coinFlip ==
                                                                        3.0
                                                                    ? const CoinFlip3p()
                                                                    : coinFlip ==
                                                                            4.0
                                                                        ? const CoinFlip4p()
                                                                        : coinFlip ==
                                                                                5.0
                                                                            ? const CoinFlip5p()
                                                                            : coinFlip == 6.0
                                                                                ? const CoinFlip6p()
                                                                                : coinFlip == 7.0
                                                                                    ? const CoinFlip7p()
                                                                                    : const CoinFlip8p()));
                                              },
                                              child: SimpleListTile(
                                                onTap: () {
                                                  Platform.isMacOS
                                                      ? null
                                                      : Platform.isWindows
                                                          ? null
                                                          : Vibration.vibrate(
                                                              duration: 10);
                                                  showOverlayNotification(
                                                      (context) {
                                                    return Padding(
                                                        padding: EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .viewPadding
                                                                    .top +
                                                                5),
                                                        child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                20,
                                                            height: 50,
                                                            child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              18),
                                                                      child: BackdropFilter(
                                                                          filter: ImageFilter.blur(
                                                                              sigmaX:
                                                                                  20,
                                                                              sigmaY:
                                                                                  20),
                                                                          child:
                                                                              Container(color: Colors.white.withOpacity(0.1)))),
                                                                  ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      child: Container(
                                                                          alignment: Alignment.center,
                                                                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: const [
                                                                            RotatedBox(
                                                                                quarterTurns: 2,
                                                                                child: Padding(padding: const EdgeInsets.only(left: 15, right: 15), child: FittedBox(fit: BoxFit.fitWidth, child: Text("Have everyone tap and hold a color to play", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)))))
                                                                          ])))
                                                                ])));
                                                  },
                                                      duration: const Duration(
                                                          milliseconds: 3000));
                                                  showOverlayNotification(
                                                      position:
                                                          NotificationPosition
                                                              .bottom,
                                                      (context) {
                                                    return Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewPadding
                                                                    .bottom +
                                                                20),
                                                        child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                20,
                                                            height: 50,
                                                            child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              18),
                                                                      child: BackdropFilter(
                                                                          filter: ImageFilter.blur(
                                                                              sigmaX:
                                                                                  20,
                                                                              sigmaY:
                                                                                  20),
                                                                          child:
                                                                              Container(color: Colors.white.withOpacity(0.1)))),
                                                                  ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      child: Container(
                                                                          alignment: Alignment.center,
                                                                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                            const Padding(
                                                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                                                child: FittedBox(fit: BoxFit.fitWidth, child: Text("Have everyone tap and hold a color to play", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20))))
                                                                          ])))
                                                                ])));
                                                  },
                                                      duration: const Duration(
                                                          milliseconds: 3000));
                                                  devModeOn == false
                                                      ? Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                            builder: (context) => coinFlip ==
                                                                    2.0
                                                                ? CoinFlip2p(
                                                                    devModeOn:
                                                                        devModeOn,
                                                                  )
                                                                : coinFlip ==
                                                                        3.0
                                                                    ? CoinFlip3p(
                                                                        devModeOn:
                                                                            devModeOn,
                                                                      )
                                                                    : coinFlip ==
                                                                            4.0
                                                                        ? CoinFlip4p(
                                                                            devModeOn:
                                                                                devModeOn,
                                                                          )
                                                                        : coinFlip ==
                                                                                5.0
                                                                            ? CoinFlip5p(
                                                                                devModeOn: devModeOn,
                                                                              )
                                                                            : coinFlip == 6.0
                                                                                ? CoinFlip6p(
                                                                                    devModeOn: devModeOn,
                                                                                  )
                                                                                : coinFlip == 7.0
                                                                                    ? CoinFlip7p(
                                                                                        devModeOn: devModeOn,
                                                                                      )
                                                                                    : CoinFlip8p(
                                                                                        devModeOn: devModeOn,
                                                                                      ),
                                                          ))
                                                      : Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              curve: Curves
                                                                  .easeOutExpo,
                                                              child: coinFlip ==
                                                                      2.0
                                                                  ? const CoinFlip2p()
                                                                  : coinFlip ==
                                                                          3.0
                                                                      ? const CoinFlip3p()
                                                                      : coinFlip ==
                                                                              4.0
                                                                          ? const CoinFlip4p()
                                                                          : coinFlip == 5.0
                                                                              ? const CoinFlip5p()
                                                                              : coinFlip == 6.0
                                                                                  ? const CoinFlip6p()
                                                                                  : coinFlip == 7.0
                                                                                      ? const CoinFlip7p()
                                                                                      : const CoinFlip8p()));
                                                },
                                                title: SizedBox(
                                                  width: double.infinity,
                                                  child: CupertinoSlider(
                                                    // key: UniqueKey(),
                                                    thumbColor: Colors.white,
                                                    activeColor: context
                                                                .isDarkMode ==
                                                            true
                                                        ? darkDynamic
                                                                ?.secondary ??
                                                            CupertinoColors
                                                                .activeBlue
                                                        : lightDynamic
                                                                ?.secondary ??
                                                            CupertinoColors
                                                                .activeBlue,
                                                    min: 2,
                                                    max: 8,
                                                    divisions: 6,
                                                    value: coinFlip,
                                                    onChanged: (value) {
                                                      Platform.isMacOS
                                                          ? null
                                                          : Platform.isWindows
                                                              ? null
                                                              : Vibration
                                                                  .vibrate(
                                                                      duration:
                                                                          10);
                                                      setState(() {
                                                        value;
                                                        coinFlip =
                                                            value; //.roundToDouble();
                                                      });
                                                    },
                                                  ),
                                                ),
                                                subtitle: Expanded(
                                                    child: Text(
                                                  'Coin Flip ${coinFlip.toStringAsFixed(coinFlip.truncateToDouble() == coinFlip ? 0 : 1)}p',
                                                  style: TextStyle(
                                                    color: context.isDarkMode ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19.5,
                                                  ),
                                                )),
                                                trailing: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: context.isDarkMode ==
                                                          true
                                                      ? darkDynamic?.primary ??
                                                          Colors.white
                                                      : lightDynamic?.primary ??
                                                          Colors.black,
                                                ),
                                                leading: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 20, sigmaY: 20),
                                                    child: Container(
                                                        color: context
                                                                .isDarkMode
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.1)
                                                            : Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                        child: Transform.scale(
                                                            scale: 2.2,
                                                            child: Image(
                                                              image: context
                                                                          .isDarkMode ==
                                                                      true
                                                                  ? const AssetImage(
                                                                      'assets/coin_light.png')
                                                                  : const AssetImage(
                                                                      'assets/coin_dark.png'),
                                                              // fit: BoxFit.cover
                                                            )))),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                tileColor: Colors.grey[300]!,
                                                circleColor:
                                                    context.isDarkMode == true
                                                        ? darkDynamic
                                                                ?.background ??
                                                            Colors.black
                                                        : lightDynamic
                                                                ?.background ??
                                                            Colors.white,
                                                circleDiameter: 80,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    const Color.fromARGB(
                                                        255, 9, 255, 0),
                                                    context.isDarkMode == true
                                                        ? darkDynamic
                                                                ?.background ??
                                                            Colors.black
                                                        : lightDynamic
                                                                ?.background ??
                                                            Colors.white,
                                                  ],
                                                ),
                                              ))))),
                              Padding(
                                  padding: const EdgeInsets.only(top: 130),
                                  child: DelayedDisplay(
                                    delay: const Duration(milliseconds: 200),
                                    child: Dismissible(
                                        resizeDuration:
                                            const Duration(milliseconds: 10),
                                        direction: devModeOn == false
                                            ? DismissDirection.startToEnd
                                            : DismissDirection.none,
                                        onDismissed: (dismissed) {
                                          Platform.isMacOS
                                              ? null
                                              : Platform.isWindows
                                                  ? null
                                                  : Vibration.vibrate(
                                                      duration: 10);
                                          CupertinoScaffold
                                              .showCupertinoModalBottomSheet(
                                            expand: false,
                                            bounce: false,
                                            useRootNavigator: false,
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) =>
                                                const FutureCamera(),
                                          );
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {});
                                          });
                                        },
                                        key: UniqueKey(),
                                        background: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('    Open?',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: context.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black))),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 20),
                                            child: Bounceable(
                                                onTap: () {
                                                  Future.delayed(
                                                      devModeOn
                                                          ? const Duration(
                                                              milliseconds:
                                                                  2500)
                                                          : const Duration(
                                                              milliseconds: 0),
                                                      () {
                                                    Platform.isMacOS
                                                        ? null
                                                        : Platform.isWindows
                                                            ? null
                                                            : Vibration.vibrate(
                                                                duration: 10);
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
                                                    );
                                                  });
                                                },
                                                child: SimpleListTile(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                  ),
                                                  onTap: () {
                                                    Platform.isMacOS
                                                        ? null
                                                        : Platform.isWindows
                                                            ? null
                                                            : Vibration.vibrate(
                                                                duration: 10);
                                                    Future.delayed(
                                                        devModeOn
                                                            ? const Duration(
                                                                milliseconds: 0)
                                                            : const Duration(
                                                                milliseconds:
                                                                    0), () {
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
                                                      );
                                                    });
                                                  },
                                                  title: Text(
                                                    'Future Predictor',
                                                    style: TextStyle(
                                                      color:
                                                          context.isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19.5,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    'See yourself in 200 years',
                                                    style: TextStyle(
                                                      color:
                                                          context.isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  trailing: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: context.isDarkMode ==
                                                            true
                                                        ? darkDynamic
                                                                ?.primary ??
                                                            Colors.white
                                                        : lightDynamic
                                                                ?.primary ??
                                                            Colors.black,
                                                  ),
                                                  leading: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 20,
                                                          sigmaY: 20),
                                                      child: Container(
                                                          color: context.isDarkMode
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.1)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: Hero(
                                                              tag: 'camera ',
                                                              transitionOnUserGestures:
                                                                  true,
                                                              child: Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  color: context.isDarkMode ==
                                                                          true
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.black,
                                                                  size: 45)))),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  tileColor: Colors.grey[300]!,
                                                  circleColor: context
                                                              .isDarkMode ==
                                                          true
                                                      ? darkDynamic
                                                              ?.background ??
                                                          Colors.black
                                                      : lightDynamic
                                                              ?.background ??
                                                          Colors.white,
                                                  circleDiameter: 80,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      const Color.fromARGB(
                                                          255, 255, 0, 0),
                                                      context.isDarkMode == true
                                                          ? darkDynamic
                                                                  ?.background ??
                                                              Colors.black
                                                          : lightDynamic
                                                                  ?.background ??
                                                              Colors.white,
                                                    ],
                                                  ),
                                                )))),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 240),
                                  child: DelayedDisplay(
                                    delay: const Duration(milliseconds: 300),
                                    child: Dismissible(
                                        onResize: () {},
                                        resizeDuration:
                                            const Duration(milliseconds: 10),
                                        direction: devModeOn == false
                                            ? DismissDirection.startToEnd
                                            : DismissDirection.none,
                                        onDismissed: (dismissed) {
                                          Platform.isMacOS
                                              ? null
                                              : Platform.isWindows
                                                  ? null
                                                  : Vibration.vibrate(
                                                      duration: 10);
                                          // Navigator.push(
                                          //     context,
                                          //     CupertinoPageRoute(
                                          //       builder: (context) =>
                                          //           RandomWord(
                                          //               darkDynamic:
                                          //                   darkDynamic,
                                          //               lightDynamic:
                                          //                   lightDynamic),
                                          //     ));
                                          CupertinoScaffold
                                              .showCupertinoModalBottomSheet(
                                            expand: false,
                                            bounce: false,
                                            enableDrag: true,
                                            useRootNavigator: false,
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) => RandomWord(
                                              darkDynamic: darkDynamic,
                                              lightDynamic: lightDynamic,
                                            ),
                                          );
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {});
                                          });
                                        },
                                        onUpdate: (details) {
                                          // setState(() {
                                          // });
                                        },
                                        key: UniqueKey(),
                                        background: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('    Open?',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: context.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black))),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 20),
                                            child: Bounceable(
                                                onTap: () {
                                                  Platform.isMacOS
                                                      ? null
                                                      : Platform.isWindows
                                                          ? null
                                                          : Vibration.vibrate(
                                                              duration: 10);
                                                  // Navigator.push(
                                                  //     context,
                                                  //     CupertinoPageRoute(
                                                  //       builder: (context) =>
                                                  //           RandomWord(
                                                  //               darkDynamic:
                                                  //                   darkDynamic,
                                                  //               lightDynamic:
                                                  //                   lightDynamic),
                                                  //     ));
                                                  CupertinoScaffold
                                                      .showCupertinoModalBottomSheet(
                                                    expand: false,
                                                    bounce: false,
                                                    enableDrag: true,
                                                    useRootNavigator: false,
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    builder: (context) =>
                                                        RandomWord(
                                                      darkDynamic: darkDynamic,
                                                      lightDynamic:
                                                          lightDynamic,
                                                    ),
                                                  );
                                                },
                                                child: SimpleListTile(
                                                  onTap: () {
                                                    Platform.isMacOS
                                                        ? null
                                                        : Platform.isWindows
                                                            ? null
                                                            : Vibration.vibrate(
                                                                duration: 10);
                                                    CupertinoScaffold
                                                        .showCupertinoModalBottomSheet(
                                                      expand: false,
                                                      bounce: false,
                                                      enableDrag: true,
                                                      useRootNavigator: false,
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder: (context) =>
                                                          RandomWord(
                                                        darkDynamic:
                                                            darkDynamic,
                                                        lightDynamic:
                                                            lightDynamic,
                                                      ),
                                                    );
                                                  },
                                                  title: Text(
                                                    'Word of the Day',
                                                    style: TextStyle(
                                                      color:
                                                          context.isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19.5,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    'Find new Words and Definitions',
                                                    style: TextStyle(
                                                      color:
                                                          context.isDarkMode ==
                                                                  true
                                                              ? Colors.white
                                                              : Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  trailing: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: context.isDarkMode ==
                                                            true
                                                        ? darkDynamic
                                                                ?.primary ??
                                                            Colors.white
                                                        : lightDynamic
                                                                ?.primary ??
                                                            Colors.black,
                                                  ),
                                                  leading: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 20,
                                                          sigmaY: 20),
                                                      child: Container(
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.white
                                                                  .withOpacity(
                                                                      0.1)
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: Icon(
                                                              Icons.abc_rounded,
                                                              color: context
                                                                          .isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              size: 55))),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  tileColor: Colors.grey[300]!,
                                                  circleColor: context
                                                              .isDarkMode ==
                                                          true
                                                      ? darkDynamic
                                                              ?.background ??
                                                          Colors.black
                                                      : lightDynamic
                                                              ?.background ??
                                                          Colors.white,
                                                  circleDiameter: 80,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      const Color.fromARGB(
                                                          255, 255, 0, 251),
                                                      context.isDarkMode == true
                                                          ? darkDynamic
                                                                  ?.background ??
                                                              Colors.black
                                                          : lightDynamic
                                                                  ?.background ??
                                                              Colors.white,
                                                    ],
                                                  ),
                                                )))),
                                  )),
                              // Padding(
                              //     padding: const EdgeInsets.only(top: 10),
                              //     child: SimpleListTile(
                              //       onTap: () => devModeOn == false
                              //           ? Navigator.push(
                              //               context,
                              //               CupertinoPageRoute(
                              //                 builder: (context) =>
                              //                     const MySettings(darkDynamic: darkDynamic, lightDynamic: lightDynamic),
                              //               ))
                              //           : Navigator.push(
                              //               context,
                              //               PageTransition(
                              //                   type: PageTransitionType
                              //                       .rightToLeft,
                              //                   curve: Curves.easeOutExpo,
                              //                   child: const MySettings(darkDynamic: darkDynamic, lightDynamic: lightDynamic))),
                              //       title: Text(
                              //         'Settings',
                              //         style: TextStyle(
                              //           color: context.isDarkMode == true
                              //               ? Colors.white
                              //               : Colors.black,
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 20,
                              //         ),
                              //       ),
                              //       trailing: Icon(
                              //         Icons.arrow_forward_ios_rounded,
                              //         color: context.isDarkMode == true
                              //             ? Colors.white
                              //             : Colors.black,
                              //       ),
                              //       leading: Icon(Icons.settings,
                              //           color: context.isDarkMode == true
                              //               ? Colors.white
                              //               : Colors.black,
                              //           size: 45),
                              //       borderRadius: BorderRadius.circular(15),
                              //       tileColor: Colors.grey[300]!,
                              //       circleColor: context.isDarkMode == true
                              //           ? Colors.black
                              //           : Colors.white,
                              //       circleDiameter: 80,
                              //       gradient: LinearGradient(
                              //         colors: [
                              //           const Color.fromARGB(
                              //               255, 123, 123, 123),
                              //           context.isDarkMode == true
                              //               ? Colors.black
                              //               : Colors.white
                              //         ],
                              //       ),
                              //     )),
                              // Padding(
                              //     padding: const EdgeInsets.only(top: 10),
                              //     child: SimpleListTile(
                              //       onTap: () => _launchURL(
                              //           "https://deusexmachinaftc.wixsite.com/home"),
                              //       title: Text(
                              //         'Deus Ex Machina',
                              //         style: TextStyle(
                              //           color: context.isDarkMode == true
                              //               ? Colors.white
                              //               : Colors.black,
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 20,
                              //         ),
                              //       ),
                              //       trailing: Icon(
                              //         Icons.open_in_new_rounded,
                              //         color: context.isDarkMode == true
                              //             ? Colors.white
                              //             : Colors.black,
                              //       ),
                              //       leading: Transform.scale(
                              //           scale: 0.9,
                              //           child: const Image(
                              //             image: AssetImage(
                              //                 'assets/demlogo.png'),
                              //             // fit: BoxFit.cover
                              //           )),
                              //       borderRadius: BorderRadius.circular(15),
                              //       tileColor: Colors.grey[300]!,
                              //       circleColor: context.isDarkMode == true
                              //           ? Colors.black
                              //           : Colors.white,
                              //       circleDiameter: 80,
                              //       gradient: LinearGradient(
                              //         colors: [
                              //           const Color.fromARGB(
                              //               255, 255, 225, 0),
                              //           context.isDarkMode == true
                              //               ? Colors.black
                              //               : Colors.white
                              //         ],
                              //       ),
                              //     )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 350),
                                  child: DelayedDisplay(
                                      delay: const Duration(milliseconds: 400),
                                      child: Dismissible(
                                          resizeDuration:
                                              const Duration(milliseconds: 10),
                                          direction:
                                              DismissDirection.startToEnd,
                                          onDismissed: (dismissed) {
                                            devModeOn == false
                                                ? Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          CupertinoScaffold(
                                                              body: MySettings(
                                                                  darkDynamic:
                                                                      darkDynamic,
                                                                  lightDynamic:
                                                                      lightDynamic)),
                                                    ))
                                                : Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        curve:
                                                            Curves.easeOutExpo,
                                                        child: CupertinoScaffold(
                                                            body: MySettings(
                                                                darkDynamic:
                                                                    darkDynamic,
                                                                lightDynamic:
                                                                    lightDynamic))));
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 500), () {
                                              setState(() {});
                                            });
                                          },
                                          key: UniqueKey(),
                                          background: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('    Open?',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: context.isDarkMode
                                                          ? Colors.white
                                                          : Colors.black))),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 20,
                                              ),
                                              child: Bounceable(
                                                  onTap: () {
                                                    devModeOn == false
                                                        ? Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                              builder: (context) => CupertinoScaffold(
                                                                  body: MySettings(
                                                                      darkDynamic:
                                                                          darkDynamic,
                                                                      lightDynamic:
                                                                          lightDynamic)),
                                                            ))
                                                        : Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                curve: Curves
                                                                    .easeOutExpo,
                                                                child: CupertinoScaffold(
                                                                    body: MySettings(
                                                                        darkDynamic:
                                                                            darkDynamic,
                                                                        lightDynamic:
                                                                            lightDynamic))));
                                                  },
                                                  child: SimpleListTile(
                                                    onTap: () {
                                                      devModeOn == false
                                                          ? Navigator.push(
                                                              context,
                                                              CupertinoPageRoute(
                                                                builder: (context) => CupertinoScaffold(
                                                                    body: MySettings(
                                                                        darkDynamic:
                                                                            darkDynamic,
                                                                        lightDynamic:
                                                                            lightDynamic)),
                                                              ))
                                                          : Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                  type: PageTransitionType
                                                                      .rightToLeft,
                                                                  curve: Curves
                                                                      .easeOutExpo,
                                                                  child: CupertinoScaffold(
                                                                      topRadius:
                                                                          Radius.circular(
                                                                              20),
                                                                      body: MySettings(
                                                                          darkDynamic:
                                                                              darkDynamic,
                                                                          lightDynamic:
                                                                              lightDynamic))));
                                                    },
                                                    title: Text(
                                                      'Settings',
                                                      style: TextStyle(
                                                        color:
                                                            context.isDarkMode ==
                                                                    true
                                                                ? Colors.white
                                                                : Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    trailing: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: context
                                                                  .isDarkMode ==
                                                              true
                                                          ? darkDynamic
                                                                  ?.primary ??
                                                              Colors.white
                                                          : lightDynamic
                                                                  ?.primary ??
                                                              Colors.black,
                                                    ),
                                                    leading: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaX: 20,
                                                                sigmaY: 20),
                                                        child: Container(
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                    .withOpacity(
                                                                        0.1)
                                                                : Colors.black
                                                                    .withOpacity(
                                                                        0.1),
                                                            child: Icon(
                                                                Icons.settings,
                                                                color: context.isDarkMode ==
                                                                        true
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                size: 45))),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    tileColor:
                                                        Colors.grey[300]!,
                                                    circleColor: context
                                                                .isDarkMode ==
                                                            true
                                                        ? darkDynamic
                                                                ?.background ??
                                                            Colors.black
                                                        : lightDynamic
                                                                ?.background ??
                                                            Colors.white,
                                                    circleDiameter: 80,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        const Color.fromARGB(
                                                            255, 123, 123, 123),
                                                        context.isDarkMode ==
                                                                true
                                                            ? darkDynamic
                                                                    ?.background ??
                                                                Colors.black
                                                            : lightDynamic
                                                                    ?.background ??
                                                                Colors.white,
                                                      ],
                                                    ),
                                                  )))))),
                            ],
                          ),
                          Center(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                      randInt == 0
                                          ? "Tip: Shake Device to Share Zpp!"
                                          : "Tip: Swipe a tile to the right to open!",
                                      style: TextStyle(
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black,
                                      ))))
                        ]))),
              )));
    });
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
