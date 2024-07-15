import 'package:cine_nest/presentation/screens/home/widgets/poster_image_widget.dart';
import 'package:cine_nest/presentation/screens/movie_details/provider/cast_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastListWidget extends StatefulWidget {
  final int movieId;
  const CastListWidget({super.key, required this.movieId});

  @override
  State<CastListWidget> createState() => _CastListWidgetState();
}

class _CastListWidgetState extends State<CastListWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<CastProvider>(context, listen: false)
        .getCasts(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CastProvider>(context);
    final casts = provider.casts;
    final isLoading = provider.isLoading;
    final failure = provider.failure;

    return isLoading! || provider.casts == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : failure != null
            ? Center(
                child: Text(failure.errorMessage),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: casts!.length,
                itemBuilder: (context, index) {
                  final cast = casts[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        PosterNetworkImageWidget(
                          posterPath: cast.profilePath!,
                        ),
                        const SizedBox(height: 20),
                        Text(cast.name!),
                        const SizedBox(height: 5),
                        Text(
                          "(${cast.character!})",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(cast.knownForDepartment!),
                      ],
                    ),
                  );
                },
              );
  }
}
