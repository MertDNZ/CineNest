import 'package:cine_nest/core/constants/constants.dart';
import 'package:flutter/material.dart';

class PosterNetworkImageWidget extends StatelessWidget {
  const PosterNetworkImageWidget(
      {super.key, required this.posterPath, required this.onError});
  final String posterPath;
  final VoidCallback onError;

  @override
  Widget build(BuildContext context) {
    return Image.network(posterUrl + posterPath, fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onError();
      });
      return Container(
        width: double.infinity,
        color: Colors.grey,
        child: const Center(
          child: Icon(
            Icons.error,
            color: Colors.black,
          ),
        ),
      );
    });
  }
}
