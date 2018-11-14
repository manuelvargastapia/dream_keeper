import 'package:flutter/material.dart';
import 'package:dream_keeper/model/idea.dart';

class PriorityDropDown extends StatelessWidget {
  final TextStyle textStyle;
  final Idea _idea;
  final List<String> _priorities;
  final Function getPriorityAsString;
  final Function updatePriorityAsInt;

  PriorityDropDown(
    this.textStyle,
    this._idea,
    this._priorities,
    this.getPriorityAsString,
    this.updatePriorityAsInt,
  );

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ListTile(
        title: DropdownButton(
            items: _priorities.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            style: textStyle,
            value: getPriorityAsString(_idea.priority),
            onChanged: (valueSelectedByUser) {
              debugPrint('User selected $valueSelectedByUser');
              updatePriorityAsInt(valueSelectedByUser);
            }),
      ),
    );
  }
}
