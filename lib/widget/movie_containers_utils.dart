import 'package:flutter/material.dart';

import '../models/movie_result_model.dart';
import '../utils/resource.dart';
import '../utils/theme_utilitys.dart';

Widget horizontalMovieContainer(Resource<MovieResultModel> resource) {
  if (resource.status == Status.LOADING) {
    return const CircularProgressIndicator();
  } else if (resource.status == Status.SUCCESS) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: resource.data!.results!.length,
        itemBuilder: (context, index) {
          final movie = resource.data!.results![index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: movie.id);
            },
            child: Container(
              // color: Colors.red,
              width: 130,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 190,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original${movie.posterPath}',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.title ?? 'null title',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  } else if (resource.status == Status.ERROR) {
    return Text(resource.errorMessage.toString());
  }
  return Container();
}

Widget verticalMovieContainer(
  Resource<MovieResultModel> resource,
  BuildContext context,
  String isEmptyMessage,
) {
  if (resource.status == Status.LOADING) {
    return const CircularProgressIndicator();
  } else if (resource.status == Status.SUCCESS) {
    if (resource.data!.results!.isNotEmpty) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resource.data!.results!.length,
        itemBuilder: (context, index) {
          final movie = resource.data!.results![index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: movie.id);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: Colors.grey[900],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: movie.backdropPath == null
                              ? const Icon(Icons.error_outline)
                              : Image.network('https://image.tmdb.org/t/p/original/${movie.backdropPath}')),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(movie.title.toString(), style: Theme.of(context).textTheme.titleLarge),
                            Row(
                              children: [
                                Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.titleSmall),
                                const Icon(Icons.star, color: Colors.yellow),
                                Text(movie.voteCount.toString(), style: Theme.of(context).textTheme.titleSmall)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
      );
    } else {
      return Center(
          child: Column(
        children: [
          mySizedBoxMedium(),
          Text(isEmptyMessage),
        ],
      ));
    }
  } else if (resource.status == Status.ERROR) {
    return Text(resource.errorMessage.toString());
  }
  return Container();
}
