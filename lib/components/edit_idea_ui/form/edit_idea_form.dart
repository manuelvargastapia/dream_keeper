import 'package:flutter/material.dart';
import 'package:dream_keeper/components/global_components/my_custom_page_indicator.dart';
import 'package:dream_keeper/components/global_components/my_custom_textfield.dart';

class EditIdeaForm extends StatefulWidget {
  final Map<String, TextEditingController> textEditingControllerMap;
  final Map<String, Function> updateFunctionMap;

  EditIdeaForm(
    this.textEditingControllerMap,
    this.updateFunctionMap,
  );

  @override
  _EditIdeaFormState createState() => _EditIdeaFormState();
}

class _EditIdeaFormState extends State<EditIdeaForm> {
  static const int _numberOfPages = 6;
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.bottomCenter,
      children: <Widget>[
        MyCustomPageIndicator(
          _numberOfPages,
          _pageIndexNotifier,
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.8,
          top: 50.0,
          child: _buildPages(),
        ),
      ],
    );
  }

  _buildPages() {
    return PageView.builder(
      itemCount: _numberOfPages,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: _switchBetweenPages(context, index),
        );
      },
      onPageChanged: (int index) {
        _pageIndexNotifier.value = index;
      },
    );
  }

  List<Widget> _switchBetweenPages(BuildContext context, int index) {
    switch (index) {
      case 0:
        return [
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['title'],
            labelText: 'Title',
            updateFunction: widget.updateFunctionMap['title'],
            maxLines: 1,
            counterText: 'Name your idea!',
          ),
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['brainstorm'],
            labelText: 'Brainstorm',
            updateFunction: widget.updateFunctionMap['brainstorm'],
            counterText: 'Write what you have in mind!',
          ),
        ];
        break;
      case 1:
        return [
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['problem'],
            labelText: 'The Problem',
            updateFunction: widget.updateFunctionMap['problem'],
            counterText: 'What\'s the need you want to solve? Be specific!',
          ),
        ];
      case 2:
        return [
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['solution'],
            labelText: 'The Solution',
            updateFunction: widget.updateFunctionMap['solution'],
            counterText: 'What\'s your solution to that problem? Be creative!',
          ),
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['activities'],
            labelText: 'Key Activities',
            updateFunction: widget.updateFunctionMap['activities'],
            counterText: 'What does your solution needs you do?',
          ),
        ];
      case 3:
        return [
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['customers'],
            labelText: 'The Customers',
            updateFunction: widget.updateFunctionMap['customers'],
            counterText:
                'Who are your customers? The more details, the better!',
          ),
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['channels'],
            labelText: 'Key Channels',
            updateFunction: widget.updateFunctionMap['channels'],
            counterText: 'How do you reach your solution to your customers?',
          ),
        ];
      case 4:
        return [
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['uniqueValue'],
            labelText: 'Unique Value',
            updateFunction: widget.updateFunctionMap['uniqueValue'],
            counterText: 'Why people shloud prefer your solution?',
          ),
        ];
      case 5:
        return [
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['costs'],
            labelText: 'Cost Structure',
            updateFunction: widget.updateFunctionMap['costs'],
            counterText: 'What activities are more expensives?',
          ),
          MyCustomTextField(
            context: context,
            controller: widget.textEditingControllerMap['revenues'],
            labelText: 'Revenues',
            updateFunction: widget.updateFunctionMap['revenues'],
            counterText: 'For what your cusomer are willing to pay? And how?',
          ),
        ];
      default:
        return [
          Container(
            child: Center(
              child: Text('Error 404: Page Not Found'),
            ),
          ),
        ];
    }
  }
}
