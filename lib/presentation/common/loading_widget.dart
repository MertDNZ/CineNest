import 'package:flutter/material.dart';

class OnLoading extends StatelessWidget {
  const OnLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
