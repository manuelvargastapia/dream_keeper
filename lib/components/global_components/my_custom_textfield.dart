import 'package:flutter/material.dart';

class MyCustomTextField extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final String labelText;
  final Function updateFunction;
  final int maxLines;
  final String counterText;

  MyCustomTextField({
    @required this.context,
    this.controller,
    this.labelText,
    this.updateFunction,
    this.maxLines = 5,
    this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = Theme.of(context).textTheme.title;

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        controller: controller,
        style: _textStyle,
        onChanged: (String value) {
          debugPrint('Current value: $value');
          updateFunction();
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: _textStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          counterText: counterText,
        ),
        maxLength: 255,
        maxLines: maxLines,
      ),
    );
  }
}
