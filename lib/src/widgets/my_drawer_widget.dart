import 'package:flutter/material.dart';
import 'package:flutter_note/screens/about_screen.dart';
import 'package:flutter_note/screens/home_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Flutter Keep',
                textScaleFactor: 2,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8,
                bottom: 4,
              ),
              child: Column(
                children: [
                  ListTile(
                    selected: routeName == HomeScreen.routeName,
                    selectedTileColor: Colors.grey.shade700,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    leading: const Icon(Icons.lightbulb_outline),
                    title: const Text('Notes'),
                    onTap: routeName != HomeScreen.routeName
                        ? () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        : null,
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.blueAccent.shade700,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8,
                bottom: 4,
              ),
              child: Column(
                children: [
                  ListTile(
                    selected: routeName == 'SettingsScreen.routeName',
                    selectedTileColor: Colors.grey.shade700,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: routeName != 'SettingsScreen.routeName'
                        ? () {
                            Navigator.pop(context);
                            // Navigator.pushNamed(context, SettingsScreen.routeName);
                          }
                        : null,
                  ),
                  ListTile(
                    selected: routeName == AboutScreen.routeName,
                    selectedTileColor: Colors.grey.shade700,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About'),
                    onTap: routeName != AboutScreen.routeName
                        ? () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AboutScreen.routeName);
                          }
                        : null,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
