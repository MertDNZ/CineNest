import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.padding = 4,
  });

  final String text;
  final double fontSize;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        text,
        softWrap: true,
        textAlign: TextAlign.center,
        style: GoogleFonts.rokkitt(
            textStyle: Theme.of(context).textTheme.headlineMedium,
            fontSize: fontSize),
      ),
    );
  }
}
