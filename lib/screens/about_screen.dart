import 'package:flutter/material.dart';
import 'package:flutter_note/src/widgets/background_image_widget.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  static const String routeName = 'about_screen';
  final String backgroundImage = 'assets/images/backgrounds/about_screen.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: BackgroundImageWidget(
          image: Svg(backgroundImage),
          child: Container(),
        ),
      ),
    );
  }
}
