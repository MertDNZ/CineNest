import 'package:cine_nest/presentation/screens/discover/discover_page.dart';
import 'package:cine_nest/presentation/screens/home/home_page.dart';
import 'package:flutter/material.dart';

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
        return const DiscoverPage();
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

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MainPages.values.length,
      child: SafeArea(
        child: Scaffold(
          //appBar: AppBar()
          bottomNavigationBar: BottomAppBar(
            child: TabBar(
              tabs: MainPages.values
                  .map<Widget>((e) => Tab(
                        icon: Icon(e.icon),
                      ))
                  .toList(),
            ),
          ),
          body: TabBarView(
            children: MainPages.values.map<Widget>((e) => (e.pages)).toList(),
          ),
        ),
      ),
    );
  }
}
