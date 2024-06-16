import 'package:cine_nest/presentation/page/skeleton.dart';
import 'package:cine_nest/presentation/provider/trending_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TrendingMoviesProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _Init(),
        //routes: {'/second': (context) => const TestPage()},
      ),
    );
  }
}

class _Init extends StatefulWidget {
  const _Init({super.key});

  @override
  State<_Init> createState() => _InitState();
}

class _InitState extends State<_Init> {
  @override
  void initState() {
    Provider.of<TrendingMoviesProvider>(context, listen: false)
        .eitherMovieOrFailureMain();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Skeleton();
  }
}
