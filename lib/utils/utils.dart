// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

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



// class MyFormFields {
//   TextFormField nameTextFormField(
//       {required String? Function(String?) validatorCallback, required TextEditingController controller}) {
//     return TextFormField(
//       validator: validatorCallback,
//       controller: controller,
//       style: TextStyle(color: CustomColors.white),
//       decoration: const InputDecoration(labelText: 'Name', floatingLabelBehavior: FloatingLabelBehavior.never),
//     );
//   }

//   TextFormField surnameTextFormField(
//       {required String? Function(String?) validatorCallback, required TextEditingController controller}) {
//     return TextFormField(
//       validator: validatorCallback,
//       controller: controller,
//       style: TextStyle(color: CustomColors.white),
//       decoration: const InputDecoration(labelText: 'Surname', floatingLabelBehavior: FloatingLabelBehavior.never),
//     );
//   }

//   TextFormField emailTextFormField(
//       {required String? Function(String?) validatorCallback, required TextEditingController controller}) {
//     return TextFormField(
//       validator: validatorCallback,
//       controller: controller,
//       style: TextStyle(color: CustomColors.white),
//       decoration: const InputDecoration(labelText: 'Email', floatingLabelBehavior: FloatingLabelBehavior.never),
//     );
//   }

//   TextFormField passwordTextFormField(
//       {required String? Function(String?) validatorCallback, required TextEditingController controller}) {
//     return TextFormField(
//         validator: validatorCallback,
//         controller: controller,
//         obscureText: true,
//         style: const TextStyle(color: Colors.white),
//         decoration: const InputDecoration(
//           labelText: 'Password',
//           floatingLabelBehavior: FloatingLabelBehavior.never,
//         ));
//   }
// }






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