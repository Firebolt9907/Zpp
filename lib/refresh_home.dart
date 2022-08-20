import 'dart:io';
import 'package:Zpp/candidates.dart';
import 'package:Zpp/coin_flip.dart';
import 'package:Zpp/coin_flip_3p.dart';
import 'package:Zpp/coin_flip_5p.dart';
import 'package:Zpp/coin_flip_6p.dart';
import 'package:Zpp/coin_flip_7p.dart';
import 'package:Zpp/coin_flip_8p.dart';
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
import 'coin_flip_4p.dart';
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
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Zpp'),
          automaticallyImplyLeading: true,
        ),
        backgroundColor:
            context.isDarkMode == true ? Colors.black : Colors.white,
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
                          padding: const EdgeInsets.only(right: 20, left: 10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: ListView(
                                children: [
                                  // Padding(
                                  Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: SimpleListTile(
                                        onTap: () {
                                          Platform.isMacOS
                                              ? null
                                              : Vibration.vibrate(duration: 10);
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
                                                            : coinFlip == 4.0
                                                                ? CoinFlip4p(
                                                                    devModeOn:
                                                                        devModeOn,
                                                                  )
                                                                : coinFlip ==
                                                                        5.0
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
                                                                          : coinFlip == 7.0
                                                                              ? const CoinFlip7p()
                                                                              : const CoinFlip8p()));
                                        },
                                        title: CupertinoSlider(
                                          min: 2,
                                          max: 8,
                                          divisions: 6,
                                          value: coinFlip,
                                          onChanged: (value) {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10);
                                            setState(() {
                                              value;
                                              coinFlip =
                                                  value; //.roundToDouble();
                                            });
                                          },
                                        ),
                                        subtitle: Text(
                                          'Coin Flip ${coinFlip.toStringAsFixed(coinFlip.truncateToDouble() == coinFlip ? 0 : 1)}p',
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
                                        leading: Transform.scale(
                                            scale: 2.2,
                                            child: Image(
                                              image: context.isDarkMode == true
                                                  ? const AssetImage(
                                                      'assets/coin_light.png')
                                                  : const AssetImage(
                                                      'assets/coin_dark.png'),
                                              // fit: BoxFit.cover
                                            )),
                                        borderRadius: BorderRadius.circular(15),
                                        tileColor: Colors.grey[300]!,
                                        circleColor: context.isDarkMode == true
                                            ? Colors.black
                                            : Colors.white,
                                        circleDiameter: 80,
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color.fromARGB(
                                                255, 9, 255, 0),
                                            context.isDarkMode == true
                                                ? Colors.black
                                                : Colors.white
                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: SimpleListTile(
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
                                        },
                                        title: Text(
                                          'Future Predictor',
                                          style: TextStyle(
                                            color: context.isDarkMode == true
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'See yourself in 200 years',
                                          style: TextStyle(
                                            color: context.isDarkMode == true
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: context.isDarkMode == true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        leading: Icon(Icons.camera_alt,
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
                                            const Color.fromARGB(
                                                255, 255, 0, 0),
                                            context.isDarkMode == true
                                                ? Colors.black
                                                : Colors.white
                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: SimpleListTile(
                                        onTap: () => _launchURL(
                                            "https://deusexmachinaftc.wixsite.com/home"),
                                        title: Text(
                                          'Deus Ex Machina',
                                          style: TextStyle(
                                            color: context.isDarkMode == true
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.open_in_new_rounded,
                                          color: context.isDarkMode == true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        leading: Transform.scale(
                                            scale: 0.9,
                                            child: const Image(
                                              image: AssetImage(
                                                  'assets/demlogo.png'),
                                              // fit: BoxFit.cover
                                            )),
                                        borderRadius: BorderRadius.circular(15),
                                        tileColor: Colors.grey[300]!,
                                        circleColor: context.isDarkMode == true
                                            ? Colors.black
                                            : Colors.white,
                                        circleDiameter: 80,
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color.fromARGB(
                                                255, 255, 225, 0),
                                            context.isDarkMode == true
                                                ? Colors.black
                                                : Colors.white
                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 40),
                                      child: SimpleListTile(
                                        onTap: () => devModeOn == false
                                            ? Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      const MySettings(),
                                                ))
                                            : Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    curve: Curves.easeOutExpo,
                                                    child: const MySettings())),
                                        title: Text(
                                          'Settings',
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
                                        leading: Icon(Icons.settings,
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
                                            const Color.fromARGB(
                                                255, 123, 123, 123),
                                            context.isDarkMode == true
                                                ? Colors.black
                                                : Colors.white
                                          ],
                                        ),
                                      )),
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
