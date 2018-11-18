import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class MyCustomPageIndicator extends StatelessWidget {
  final int _numberOfPages;
  final ValueNotifier<int> _pageIndexNotifier;

  MyCustomPageIndicator(
    this._numberOfPages,
    this._pageIndexNotifier,
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.0,
      child: PageViewIndicator(
        pageIndexNotifier: _pageIndexNotifier,
        length: _numberOfPages,
        normalBuilder: (AnimationController animContr) {
          return Circle(
            size: 10.0,
            color: Colors.black54,
          );
        },
        highlightedBuilder: (AnimationController animContr) {
          return ScaleTransition(
            scale: CurvedAnimation(
              parent: animContr,
              curve: Curves.ease,
            ),
            child: Circle(
              size: 12.0,
              color: Colors.yellowAccent,
            ),
          );
        },
      ),
    );
  }
}
