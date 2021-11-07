import 'package:flutter/material.dart';
import 'package:flutter_note/src/util/screen_size_config.dart';

class BuildBottomNavigationBarWidget extends StatelessWidget {
  const BuildBottomNavigationBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
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
              icon: Icon(
                Icons.home_outlined,
                size: ScreenSizeConfig.safeBlockHorizontal * 7,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.search_outlined,
                size: ScreenSizeConfig.safeBlockHorizontal * 7,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'About App',
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.info_outline,
                size: ScreenSizeConfig.safeBlockHorizontal * 7,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
