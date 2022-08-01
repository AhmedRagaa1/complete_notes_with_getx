import 'package:flutter/material.dart';

class AlertDioooog extends StatelessWidget
{

  final String contentText;
  final Function confirmFunction;
  final Function declineFunction;


  AlertDioooog({this.contentText, this.confirmFunction, this.declineFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(contentText),
      actions:
      [
        TextButton(
            onPressed: confirmFunction,
            child: Text(
              'yes'
            )),
        TextButton(
            onPressed: declineFunction,
            child: Text(
              'No'
            )),

      ],
    );
  }
}
