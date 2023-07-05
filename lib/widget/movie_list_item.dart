// import 'package:flutter/material.dart';
// import 'package:movie_app/models/movie_result_model.dart';

// class MoviewListItem extends StatelessWidget {
//   Results movie;
//   Function() onTap;
//   MoviewListItem({super.key, required this.movie, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // viewModel.getFavorites();
//         // Navigator.pushNamed(context, '/detail', arguments: movie.id);
//         // viewModel.refreash();

//         _navigateAndUpdateFavorites(context, movie.id ?? 0);
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 15.0),
//         child: Container(
//             width: MediaQuery.of(context).size.width,
//             margin: const EdgeInsets.symmetric(horizontal: 8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               // color: Colors.grey[900],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: movie.backdropPath == null
//                         ? const Icon(Icons.error_outline)
//                         : Image.network('https://image.tmdb.org/t/p/original/${movie.backdropPath}')),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(movie.title.toString(), style: Theme.of(context).textTheme.titleLarge),
//                       Row(
//                         children: [
//                           Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.titleSmall),
//                           const Icon(Icons.star, color: Colors.yellow),
//                           Text(movie.voteCount.toString(), style: Theme.of(context).textTheme.titleSmall)
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
