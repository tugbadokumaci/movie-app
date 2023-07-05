// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/pages/settings_page/settings_cubit.dart';
// import 'package:movie_app/pages/settings_page/settings_state.dart';

// import '../../utils/theme_utilitys.dart';

// class SettingsView extends StatelessWidget {
//   SettingsCubit viewModel;
//   SettingsView({super.key, required this.viewModel});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<SettingsCubit>(
//       create: (_) => viewModel,
//       child: _buildScaffold(context),
//     );
//   }

//   Scaffold _buildScaffold(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: BlocConsumer<SettingsCubit, SettingsState>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               if (state is SettingsInitial) {
//                 return _buildInitial();
//               } else if (state is SettingsLoading) {
//                 return _buildLoading();
//               } else if (state is SettingsSuccess) {
//                 // return _buildSuccess();
//               }
//               return Container();
//             }));
//   }

//   Widget _buildInitial() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           mySizedBoxMedium(),
//           TextButton(
//               onPressed: () {
//                 viewModel.logOut();
//               },
//               child: const Row(
//                 children: [
//                   Icon(Icons.logout_outlined),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text('Log out')
//                 ],
//               ))
//         ],
//       ),
//     );
//   }

//   Widget _buildLoading() {
//     return Center(
//       child: LinearProgressIndicator(
//         color: CustomColors.white,
//         backgroundColor: CustomColors.red,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../inheritance/mixin_logout.dart';
import '../../utils/theme_utilitys.dart';

class SettingsView extends StatelessWidget with ILogout {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            mySizedBoxMedium(),
            TextButton(
                onPressed: () {
                  logout();
                  Navigator.pushNamed(context, '/logIn');
                },
                child: Row(
                  children: [
                    const Icon(Icons.logout_outlined, color: Colors.white),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('Log out', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
