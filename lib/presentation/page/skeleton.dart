import 'package:cine_nest/presentation/dialogs/error_dialog.dart';
import 'package:cine_nest/presentation/page/home_page.dart';
import 'package:cine_nest/presentation/provider/trending_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MainPages {
  home,
  search,
}

extension PageProperties on MainPages {
  Widget get pages {
    switch (this) {
      case MainPages.home:
        return const HomePage();
      case MainPages.search:
        return const Scaffold(
          body: Center(
            child: Text("data"),
          ),
        );
    }
  }

  IconData get icon {
    switch (this) {
      case MainPages.home:
        return Icons.home;
      case MainPages.search:
        return Icons.search;
    }
  }
}

class Skeleton extends StatefulWidget {
  const Skeleton({super.key});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: MainPages.values.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TrendingMoviesProvider>(context);
    final failure = provider.failure;

    if (failure != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, failure.errorMessage);
      });
      return Scaffold(
        body: Center(
          child: Text(failure.errorMessage),
        ),
      );
    } else {
      return DefaultTabController(
        length: MainPages.values.length,
        child: SafeArea(
          child: Scaffold(
            //appBar: AppBar()
            bottomNavigationBar: BottomAppBar(
                child: TabBar(
                    controller: _tabController,
                    tabs: MainPages.values
                        .map<Widget>((e) => Tab(
                              icon: Icon(e.icon),
                            ))
                        .toList())),
            body: TabBarView(
              controller: _tabController,
              children: MainPages.values.map<Widget>((e) => (e.pages)).toList(),
            ),
          ),
        ),
      );
    }
  }
}
