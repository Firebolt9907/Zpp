import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:simple_list_tile/simple_list_tile.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:iconforest_arcticons/arcticons.dart';

import 'main.dart';

class MySocial extends StatelessWidget {
  const MySocial({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    Platform.isMacOS ? null : Vibration.vibrate(duration: 10, amplitude: 128);
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CupertinoPageScaffold(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  systemNavigationBarContrastEnforced: false,
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
                sized: false,
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: CupertinoPageScaffold(
                        navigationBar: const CupertinoNavigationBar(
                          middle: Text('Social Links'),
                          automaticallyImplyLeading: true,
                          previousPageTitle: "Settings",
                          transitionBetweenRoutes: true,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 20, 20, 20),
                            child: ListView(
                              reverse: true,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: SimpleListTile(
                                      onTap: () => _launchURL(
                                          "https://www.roblox.com/users/690475268/profile"),
                                      title: Text(
                                        'Roblox',
                                        style: TextStyle(
                                          color: context.isDarkMode == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
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
                                      trailing: Icon(
                                        Icons.open_in_new_rounded,
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      leading: Transform.scale(
                                          scale: 0.8,
                                          child: Arcticons(Arcticons.roblox,
                                              color: context.isDarkMode == true
                                                  ? Colors.white
                                                  : Colors.black)),
                                      borderRadius: BorderRadius.circular(15),
                                      tileColor: Colors.grey[300]!,
                                      circleColor: context.isDarkMode == true
                                          ? Colors.black
                                          : Colors.white,
                                      circleDiameter: 80,
                                      gradient: LinearGradient(
                                        colors: [
                                          const ui.Color.fromARGB(
                                              255, 128, 128, 128),
                                          context.isDarkMode == true
                                              ? Colors.black
                                              : Colors.white
                                        ],
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: SimpleListTile(
                                      onTap: () => _launchURL(
                                          "https://discord.gg/HSmAerG2VX"),
                                      title: Text(
                                        'Discord Server',
                                        style: TextStyle(
                                          color: context.isDarkMode == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
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
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      leading: Transform.scale(
                                          scale: 0.8,
                                          child: Arcticons(Arcticons.discord,
                                              color: context.isDarkMode == true
                                                  ? Colors.white
                                                  : Colors.black)),
                                      borderRadius: BorderRadius.circular(15),
                                      tileColor: Colors.grey[300]!,
                                      circleColor: context.isDarkMode == true
                                          ? Colors.black
                                          : Colors.white,
                                      circleDiameter: 80,
                                      gradient: LinearGradient(
                                        colors: [
                                          const ui.Color.fromARGB(
                                              255, 45, 0, 245),
                                          context.isDarkMode == true
                                              ? Colors.black
                                              : Colors.white
                                        ],
                                      ),
                                    )),
                                CupertinoListTile(
                                    leading: Arcticons(Arcticons.snapchat,
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
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
                                              text: '"Stop spamming ur story"',
                                              style: TextStyle(
                                                  fontStyle:
                                                      ui.FontStyle.italic)),
                                          TextSpan(text: ' -Yatharth Sirohi')
                                        ],
                                      ),
                                    ),
                                    onTap: () => _launchURL(
                                        "https://www.snapchat.com/add/firebolt_9907?share_id=6bLdC4GNgg8&locale=en-US")),
                                CupertinoListTile(
                                    leading: Arcticons(Arcticons.minecraft,
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
                                    title:
                                        const Text('Look at me on Minecraft'),
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
                                    leading: Arcticons(Arcticons.youtube,
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
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
                                    leading: Arcticons(Arcticons.xbox,
                                        fit: BoxFit.contain,
                                        color: context.isDarkMode == true
                                            ? Colors.white
                                            : Colors.black),
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
                                    title: const Text('Follow my Xbox Account'),
                                    onTap: () => _launchURL(
                                        "https://live.xbox.com/Profile?Gamertag=Firebolt9907582")),
                              ],
                            )))))));
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
