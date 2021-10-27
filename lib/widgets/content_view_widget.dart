import 'package:flutter/material.dart';

import '../models/content_models.dart';

class ContentViewWidget extends StatelessWidget {
  final List<Content> contentsList;

  const ContentViewWidget({
    Key? key,
    required this.contentsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: contentsList.length,
      itemBuilder: (context, index) {
        Content content = contentsList[index];
        return Text(
          content.noteText,
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      },
    );
  }
}
