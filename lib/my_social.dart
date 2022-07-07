import 'dart:ui' as ui;
import 'dart:ui';
import 'package:Zpp/about_us.dart';
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
import 'package:overlay_support/overlay_support.dart';

import 'main.dart';

class MySocial extends StatelessWidget {
  MySocial({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    Vibration.vibrate(duration: 10, amplitude: 128);
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Scaffold(
                body: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                        systemStatusBarContrastEnforced: false,
                        systemNavigationBarColor: Colors.transparent,
                        systemNavigationBarDividerColor: Colors.transparent,
                        systemNavigationBarIconBrightness: Brightness.dark,
                        statusBarIconBrightness: Brightness.dark),
                    sized: false,
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: CupertinoPageScaffold(
                            navigationBar: const CupertinoNavigationBar(
                              middle: Text('Social Links'),
                              automaticallyImplyLeading: true,
                              previousPageTitle: "Home",
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  reverse: true,
                                  children: [
                                    CupertinoListTile(
                                        //leading: Icon(),
                                        title:
                                            const Text('Friend me on Roblox'),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'Of course i dont game on my school mac'),
                                            ],
                                          ),
                                        ),
                                        onTap: () => _launchURL(
                                            "https://www.roblox.com/users/690475268/profile")),
                                    CupertinoListTile(
                                        title: const Text(
                                            'Join my Discord Server'),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'Finally a messaging app that isnt trash'),
                                            ],
                                          ),
                                        ),
                                        onTap: () => _launchURL(
                                            "https://discord.gg/HSmAerG2VX")),
                                    CupertinoListTile(
                                        title: const Text('Add me on Snapchat'),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '"Stop spamming ur story"',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          ui.FontStyle.italic)),
                                              TextSpan(
                                                  text: ' -Yatharth Sirohi')
                                            ],
                                          ),
                                        ),
                                        onTap: () => _launchURL(
                                            "https://www.snapchat.com/add/firebolt_9907?share_id=6bLdC4GNgg8&locale=en-US")),
                                    CupertinoListTile(
                                        title: const Text(
                                            'Look at me on Minecraft'),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(text: 'The '),
                                              TextSpan(
                                                  text: 'game',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          ui.FontStyle.italic)),
                                              TextSpan(text: ' who lived'),
                                            ],
                                          ),
                                        ),
                                        onTap: () => _launchURL(
                                            "https://namemc.com/profile/Firebolt_9907.1")),
                                    CupertinoListTile(
                                        title: const Text(
                                            'Subscribe to me on YouTube'),
                                        subtitle: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'I dare u to find the rickroll in this app'),
                                            ],
                                          ),
                                        ),
                                        onTap: () => _launchURL(
                                            "https://www.youtube.com/channel/UChcPleeg20FGQP2v3sz9MDQ")),
                                    CupertinoListTile(
                                        subtitle: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'LOOKING AT U PLAYSTATION GANG'),
                                            ],
                                          ),
                                        ),
                                        title: const Text(
                                            'Follow my Xbox Account'),
                                        onTap: () => _launchURL(
                                            "https://live.xbox.com/Profile?Gamertag=Firebolt9907582")),
                                  ],
                                ))))))));
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
