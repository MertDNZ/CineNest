import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Details"),
      ),
      body: const Center(
        child: Hero(
          tag: "movie-detail-page",
          child: Text("Some Movie Details"),
        ),
      ),
    );
  }
}
