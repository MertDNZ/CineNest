import 'dart:developer';
import 'package:cine_nest/config/routes/route_constants.dart';
import 'package:cine_nest/core/constants/constants.dart';
import 'package:cine_nest/domain/entities/genre_entity.dart';
import 'package:cine_nest/presentation/common/loading_widget.dart';
import 'package:cine_nest/presentation/common/on_failure_widget.dart';
import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/screens/discover/providers/discover_page_provider.dart';
import 'package:cine_nest/presentation/screens/discover/widgets/custom_search_delegate.dart';
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
    final provider = Provider.of<DiscoverPageProvider>(context);
    final genres = provider.genres;
    final isLoading = provider.isLoading;
    final failure = provider.failure;

    if (isLoading!) {
      return const OnLoading();
    } else if (failure != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, failure.errorMessage);
      });
      return OnFailure(
        failure: failure,
        onRefresh: _onRefresh,
      );
    } else {
      return _onSuccess(genres, provider);
    }
  }

  Scaffold _onSuccess(
      List<GenreEntity>? genres, DiscoverPageProvider provider) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          discoverText,
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 35,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(provider: provider),
              );
            },
          ),
        ],
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
