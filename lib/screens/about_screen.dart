import 'package:flutter/material.dart';
import 'package:flutter_note/src/util/my_constants.dart';
import 'package:flutter_note/src/util/my_screen_size.dart';
import 'package:flutter_note/src/widgets/my_bottom_nav_bar_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  static const String routeName = 'about_screen';

  @override
  Widget build(BuildContext context) {
    MyScreenSize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              16, MyScreenSize.safeBlockVertical * 5, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: MyScreenSize.safeBlockHorizontal * 15,
                child: FlutterLogo(
                  size: MyScreenSize.safeBlockHorizontal * 15,
                ),
              ),
              const Text(
                'Flutter Keep',
                softWrap: true,
                textScaleFactor: 3,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Hadi Mahmoudi',
                softWrap: true,
                textScaleFactor: 2,
                style: TextStyle(
                  color: Colors.grey,
                ),
                strutStyle: StrutStyle(),
              ),
              const SizedBox(height: 5),
              Text(
                kMail,
                softWrap: true,
                textScaleFactor: 1,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      _launchInBrowser(kUrlGitHub);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchInBrowser(kUrlWebsite);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.html5,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchInBrowser(kUrlLinkedin);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Text(
                    'About',
                    textAlign: TextAlign.left,
                    textScaleFactor: 2,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  Text(
                      'A free Flutter app to keep your Note and Todo list.\n '),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavBar(
        routeName: AboutScreen.routeName,
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
