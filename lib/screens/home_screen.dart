import 'package:flutter/material.dart';

import '../widgets/sliver_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// SliverAppBar Settings
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;

  /// Expanded Card Settings
  bool _isTapped = true;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 160.0,
              backgroundColor: Colors.deepPurple,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('MY NOTE'),
                background: Padding(
                  padding: EdgeInsets.only(left: 100.0),
                  child: FlutterLogo(),
                ),
              ),
            ),
            SliverListWidget(
              onTap: () {
                setState(() {
                  _isTapped = !_isTapped;
                });
              },
              onHighlightChanged: (value) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              isTapped: _isTapped,
              isExpanded: _isExpanded,
            )
          ],
        ),
      ),
    );
  }
}
