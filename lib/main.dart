import 'dart:convert';

import 'package:cine_nest/config/routes/routes.dart';
import 'package:cine_nest/presentation/screens/discover/providers/discover_page_provider.dart';
import 'package:cine_nest/presentation/screens/movie_detail/movie_detail_page.dart';
import 'package:cine_nest/presentation/screens/skeleton.dart';
import 'package:cine_nest/presentation/screens/home/providers/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString("lib/config/theme/theme.json");
  final themeJson = await jsonDecode(themeStr);
  final toTheme = ThemeDecoder.decodeThemeData(themeJson)!;
  final theme =
      toTheme.copyWith(textTheme: GoogleFonts.latoTextTheme(toTheme.textTheme));
  runApp(MyApp(
    theme: theme,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        ChangeNotifierProvider(create: (context) => DiscoverPageProvider())
      ],
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: const _Init(),
        routes: {detailScreen: (context) => const MovieDetailPage()},
      ),
    );
  }
}

class _Init extends StatefulWidget {
  const _Init();
  @override
  State<_Init> createState() => _InitState();
}

class _InitState extends State<_Init> {
  @override
  void initState() {
    Provider.of<HomePageProvider>(context, listen: false).fetchMovies();
    Provider.of<DiscoverPageProvider>(context, listen: false).fetchGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Skeleton();
  }
}
