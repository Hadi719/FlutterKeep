import 'package:flutter/material.dart';
import 'package:flutter_keep/screens/about_screen.dart';
import 'package:flutter_keep/screens/home_screen.dart';
import 'package:flutter_keep/src/util/my_screen_size.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  final String routeName;

  @override
  Widget build(BuildContext context) {
    bool _showNotch = true;
    MyScreenSize().init(context);
    return BottomAppBar(
      shape: _showNotch ? const CircularNotchedRectangle() : null,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 64, 16),
        height: MyScreenSize.safeBlockVertical * 8,
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
                size: MyScreenSize.safeBlockHorizontal * 7,
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
                size: MyScreenSize.safeBlockHorizontal * 7,
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
                size: MyScreenSize.safeBlockHorizontal * 7,
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
