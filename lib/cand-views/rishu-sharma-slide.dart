import 'package:flutter/material.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:flutter/services.dart';

class Slide extends StatelessWidget {
  const Slide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // TODO: implement build
    return DismissiblePage(
        onDismissed: () {
          Navigator.of(context).pop();
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        },
        // Note that scrollable widget inside DismissiblePage might limit the functionality
        // If scroll direction matches DismissiblePage direction
        direction: DismissiblePageDismissDirection.multi,
        isFullScreen: true,
        backgroundColor: const Color.fromARGB(122, 0, 0, 0),
        child: FullScreenWidget(
          child: Center(
              child: Hero(
            transitionOnUserGestures: true,
            tag: "rishu-sharma",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/rishu-campaign.jpg",
              ),
            ),
          )),
        ));
  }
}
