import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/core/errors/failure.dart';
import 'package:flutter/material.dart';

class OnFailure extends StatelessWidget {
  const OnFailure({super.key, required this.failure, required this.onRefresh});
  final Failure? failure;
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(failure!.errorMessage),
              TextButton(
                onPressed: onRefresh,
                child: const Text(refreshButtonString),
              ),
            ]),
      ),
    );
  }
}
