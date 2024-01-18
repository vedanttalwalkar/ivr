import 'package:flutter/material.dart';
import 'package:ivrapp/constants.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Stack(alignment: AlignmentDirectional.center, children: [
        Divider(indent: 8, endIndent: 8),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: whiteColor,
              border: Border.all(color: Colors.grey)),
          child: Text(
            "OR",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
