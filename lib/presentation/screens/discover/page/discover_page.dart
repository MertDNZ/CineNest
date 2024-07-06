import 'dart:developer';
import 'package:cine_nest/assets/genre_image_dict.dart';
import 'package:cine_nest/config/routes/route_constants.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/presentation/common/loading_widget.dart';
import 'package:cine_nest/presentation/common/on_failure_widget.dart';
import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/screens/discover/providers/discover_page_provider.dart';
import 'package:cine_nest/presentation/screens/discover/widgets/genre_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  Future<void> _onRefresh() {
    Provider.of<DiscoverPageProvider>(context, listen: false).fetchGenres();
    setState(() {});
    return Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscoverPageProvider>(context, listen: false);
    final genres = provider.genres;
    final isLoading = provider.isLoading;
    final failure = provider.failure;

    if (isLoading!) {
      return const OnLoading();
    } else if (failure != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, failure.errorMessage);
      });
      return OnFailure(failure: failure, onRefresh: _onRefresh);
    } else {
      return _onSuccess(genres);
    }
  }

  String _imagePath({required GenreEntity genre}) {
    final String genreString = genre.genre;
    for (var map in genreList) {
      if (map["title"] == genreString) {
        return map["image"] ?? defaultImagePath;
      }
    }
    return defaultImagePath;
  }

  Scaffold _onSuccess(List<GenreEntity>? genres) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          discoverScreenText,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: genres!.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return InkWell(
            hoverColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, filteredPage,
                  arguments: {'genre': genre});
              log('on tapped');
              log(genre.id.toString());
            },
            child: GenreCard(genre: genre),
          );
        },
      ),
    );
  }
}
