import 'package:flutter/material.dart';
import './pages/home_page.dart';

void main() => runApp(DreamKeeper());

class DreamKeeper extends StatelessWidget {
  final String _appName = 'Dream Keeper';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
