import 'package:flutter/material.dart';
import 'package:flutter_note/screens/about_screen.dart';
import 'package:flutter_note/screens/home_screen.dart';
import 'package:flutter_note/src/util/screen_size_config.dart';

class BuildBottomNavigationBarWidget extends StatelessWidget {
  const BuildBottomNavigationBarWidget({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  final String routeName;

  @override
  Widget build(BuildContext context) {
    bool _showNotch = true;
    ScreenSizeConfig().init(context);
    return BottomAppBar(
      shape: _showNotch ? const CircularNotchedRectangle() : null,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 64, 16),
        height: ScreenSizeConfig.safeBlockVertical * 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              tooltip: 'Home',
              highlightColor: Colors.transparent,
              color: routeName == HomeScreen.routeName
                  ? Theme.of(context).colorScheme.secondary
                  : null,
              icon: Icon(
                Icons.home_outlined,
                size: ScreenSizeConfig.safeBlockHorizontal * 7,
              ),
              onPressed: () {
                if (routeName != HomeScreen.routeName) {
                  Navigator.pop(context);
                }
              },
            ),
            IconButton(
              tooltip: 'Search',
              highlightColor: Colors.transparent,
              // color: routeName == SearchScreen.routeName
              //     ? Theme.of(context).colorScheme.secondary
              //     : null,
              icon: Icon(
                Icons.search_outlined,
                size: ScreenSizeConfig.safeBlockHorizontal * 7,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'About App',
              highlightColor: Colors.transparent,
              color: routeName == AboutScreen.routeName
                  ? Theme.of(context).colorScheme.secondary
                  : null,
              icon: Icon(
                Icons.info_outline,
                size: ScreenSizeConfig.safeBlockHorizontal * 7,
              ),
              onPressed: () async {
                if (routeName != AboutScreen.routeName) {
                  await Navigator.pushNamed(context, AboutScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
