import 'package:flutter/material.dart';

class SliverListWidget extends StatelessWidget {
  final Function() onTap;
  final Function(bool) onHighlightChanged;
  final bool isTapped;
  final bool isExpanded;

  const SliverListWidget({
    Key? key,
    required this.onTap,
    required this.onHighlightChanged,
    required this.isTapped,
    required this.isExpanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: onTap,
            onHighlightChanged: onHighlightChanged,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                padding: EdgeInsets.all(20),
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                height: isTapped
                    ? isExpanded
                        ? 65
                        : 70
                    : isExpanded
                        ? 225
                        : 230,
                width: isExpanded ? 385 : 390,
                decoration: BoxDecoration(
                  color: Color(0xff6F12E8),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff6F12E8).withOpacity(0.5),
                      blurRadius: 20,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: isTapped
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tap To Expand',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                isTapped
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 27,
                              )
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'tap to expand',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                isTapped
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 27,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            isTapped
                                ? ''
                                : 'laskdfksdlkf ksdjflkj lskdjfkljs dlkjf.'
                                    's;ldkflkgj;sldkfgljs;dlf;lkds;flkg;lkjsdflgk;lsdkfjds',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
              ),
            ),
          );
        },
        childCount: 10,
      ),
    );
  }
}
