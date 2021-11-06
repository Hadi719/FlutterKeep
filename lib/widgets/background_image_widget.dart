import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final ImageProvider image;
  final Widget child;

  const BackgroundImageWidget({
    Key? key,
    required this.image,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(),
        child,
      ],
    );
  }

  Widget buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.fitWidth,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: child,
    );
  }
}

// ShaderMask(
// blendMode: BlendMode.darken,
// shaderCallback: (Rect bounds) {
//   return const LinearGradient(
//     colors: [Colors.black38, Colors.black87],
//     begin: Alignment.center,
//     end: Alignment.bottomCenter,
//   ).createShader(bounds);
// },
// child:
