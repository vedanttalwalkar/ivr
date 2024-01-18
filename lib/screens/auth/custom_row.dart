import 'package:flutter/material.dart';
import 'package:ivrapp/constants.dart';

class CustomRow extends StatelessWidget {
  const CustomRow(
      {required this.buttonContent,
      required this.function,
      required this.supportingText,
      super.key});
  final String buttonContent;
  final String supportingText;
  final function;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            supportingText,
            style: TextStyle(color: Colors.black54),
          ),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 50),
              side: BorderSide(color: greenColor)),
          onPressed: function,
          child: Text(
            buttonContent,
            style: TextStyle(color: greenColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
