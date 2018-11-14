import 'package:flutter/material.dart';

class IdeaDetailsForm extends StatelessWidget {
  final TextStyle textStyle;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController problemController;
  final TextEditingController customerController;
  final TextEditingController valuePropositionController;
  final Function updateTitle;
  final Function updateDescription;
  final Function updateProblemToSolve;
  final Function updateCustomerSegment;
  final Function updateValueProposition;

  IdeaDetailsForm(
    this.textStyle,
    this.titleController,
    this.descriptionController,
    this.problemController,
    this.customerController,
    this.valuePropositionController,
    this.updateTitle,
    this.updateDescription,
    this.updateProblemToSolve,
    this.updateCustomerSegment,
    this.updateValueProposition,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTextField(
          controller: titleController,
          text: 'Title',
          updateFunction: updateTitle,
        ),
        _buildTextField(
          controller: descriptionController,
          text: 'Description',
          updateFunction: updateDescription,
        ),
        _buildTextField(
          controller: problemController,
          text: 'Problem to Solve',
          updateFunction: updateProblemToSolve,
        ),
        _buildTextField(
          controller: customerController,
          text: 'Customer Segment',
          updateFunction: updateCustomerSegment,
        ),
        _buildTextField(
          controller: valuePropositionController,
          text: 'Value Proposition',
          updateFunction: updateValueProposition,
        ),
      ],
    );
  }

  Widget _buildTextField({
    TextEditingController controller,
    String text,
    Function updateFunction,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: TextField(
        controller: controller,
        style: textStyle,
        onChanged: (value) {
          debugPrint('Something changed in $text Text Field');
          updateFunction();
        },
        decoration: InputDecoration(
          labelText: text,
          labelStyle: textStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
