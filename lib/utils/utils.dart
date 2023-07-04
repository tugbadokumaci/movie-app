// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_app/utils/resource.dart';
import 'package:movie_app/utils/theme_utilitys.dart';

import '../models/movie_result_model.dart';

class Utils {
  Utils._();

  static void showCustomDialog(
      {required BuildContext context, required String title, required String content, required Function onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                onTap();
                // Navigator.pop(context);
                // Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

mixin NavigatorManager {
  // constructor sız class
  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: true,
        settings: const RouteSettings()));
  }

  Future<T?> navigateToWidgetNormal<T>(BuildContext context, Widget widget) {
    return Navigator.of(context).push<T>(MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        fullscreenDialog: true,
        settings: const RouteSettings()));
  }
}

void navigateToNewRoute(BuildContext context, String newRouteName) {
  final currentRoute = ModalRoute.of(context)?.settings.name;
  debugPrint(currentRoute); // null
  debugPrint(newRouteName);
  if (currentRoute != newRouteName) {
    Navigator.pushNamed(context, newRouteName);
  }
}

class MyButton {
  Container myRedButton(
      {required BuildContext context,
      required double height,
      required double width,
      required String label,
      required void Function()? onPressed}) {
    return Container(
      height: height,
      width: width,

      // margin: const EdgeInsets.symmetric(horizontal: 60),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.red, shape: BoxShape.rectangle),
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class MyFormFields {
  TextFormField nameTextFormField(
      {required String? Function(String?) validatorCallback, required TextEditingController controller}) {
    return TextFormField(
      validator: validatorCallback,
      controller: controller,
      style: TextStyle(color: CustomColors.white),
      decoration: const InputDecoration(labelText: 'Name', floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }

  TextFormField surnameTextFormField(
      {required String? Function(String?) validatorCallback, required TextEditingController controller}) {
    return TextFormField(
      validator: validatorCallback,
      controller: controller,
      style: TextStyle(color: CustomColors.white),
      decoration: const InputDecoration(labelText: 'Surname', floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }

  TextFormField emailTextFormField(
      {required String? Function(String?) validatorCallback, required TextEditingController controller}) {
    return TextFormField(
      validator: validatorCallback,
      controller: controller,
      style: TextStyle(color: CustomColors.white),
      decoration: const InputDecoration(labelText: 'Email', floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }

  TextFormField passwordTextFormField(
      {required String? Function(String?) validatorCallback, required TextEditingController controller}) {
    return TextFormField(
        validator: validatorCallback,
        controller: controller,
        obscureText: true,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'Password',
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ));
  }
}

class BackgroundImage extends StatelessWidget {
  Shader Function(Rect) shaderCallback;
  BackgroundImage({super.key, required this.shaderCallback});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: shaderCallback,
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/movie_app_login_screen.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}

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

Widget verticalMovieContainer(Resource<MovieResultModel> resource, BuildContext context, String isEmptyMessage) {
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



// Widget verticalMovieContainer(Resource<MovieResultModel> resource, BuildContext context, String isEmptyMessage ) {
//   if (resource.status == Status.LOADING) {
//     return const CircularProgressIndicator();
//   } else if (resource.status == Status.SUCCESS) {
//     return Container(
//       height: 3000, // IS IT A GOOD PRACTİCE ???
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: resource.data!.results!.length,
//         itemBuilder: (context, index) {
//           final movie = resource.data!.results![index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, '/detail', arguments: movie);
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 15.0),
//               child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     // color: Colors.grey[900],
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                           child: movie.backdropPath == null
//                               ? const Icon(Icons.error_outline)
//                               : Image.network('https://image.tmdb.org/t/p/original/${movie.backdropPath}')),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(movie.title.toString(), style: Theme.of(context).textTheme.titleLarge),
//                             Row(
//                               children: [
//                                 Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.titleSmall),
//                                 const Icon(Icons.star, color: Colors.yellow),
//                                 Text(movie.voteCount.toString(), style: Theme.of(context).textTheme.titleSmall)
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   )),
//             ),
//           );
//         },
//       ),
//     );
//   } else if (resource.status == Status.ERROR) {
//     return Text(resource.errorMessage.toString());
//   }
//   return Container();
// }