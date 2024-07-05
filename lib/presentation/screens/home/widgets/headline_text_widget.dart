import 'package:flutter/material.dart';

class CustomHeadline extends StatelessWidget {
  const CustomHeadline(
      {super.key, required this.headline, required this.fontSize});
  final double? fontSize;
  final String headline;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
          child: Text(
            headline,
            style: TextStyle(fontSize: fontSize),
          ),
        )
      ],
    );
  }
}
