// ignore_for_file: type_init_formals, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/widget/text_field_utils.dart';
import 'package:movie_app/utils/theme_utilitys.dart';
import '../../widget/bg_image_utils.dart';
import '../../widget/button_utils.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget {
  final LoginCubit viewModel;
  LoginView({super.key, required this.viewModel});

  static final formKey = GlobalKey<FormState>(); // for keyboard to not shout down imidiatly
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider<LoginCubit>(
        create: (_) => viewModel,
        child: Stack(
          children: [
            BackgroundImage(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [Colors.black, Colors.black12],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ).createShader(bounds);
              },
            ),
            _buildScaffold(height, context),
          ],
        ));
  }

  Scaffold _buildScaffold(double height, BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              debugPrint('NAvigate pldum');
              Navigator.pushNamed(context, '/');
            }
          },
          builder: (context, state) {
            debugPrint('State is : $state');
            if (state is LoginInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                viewModel.initialize();
              });

              return _buildInitial(height, context);
            } else if (state is LoginLoading) {
              // return _buildLoading();
            } else if (state is LoginSuccess) {
              return Container();
            }
            // else if (state is LoginError) {
            // final result = state as LoginError;
            // return _buildError(state.message);
            // }
            return Container();
          },
        )));
  }

  Center _buildInitial(double height, BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            projectNameTitle(context),
            mySizedBoxLarge(),
            // SizedBox(width: 350, child: emailField()),
            emailField(350),
            mySizedBoxSmall(),
            // SizedBox(width: 350, child: passwordField()),
            passwordField(350),
            mySizedBoxSmall(),
            signInButton(context),
            mySizedBoxMedium(),
            Text('Social Logins', style: Theme.of(context).textTheme.titleMedium),
            mySizedBoxSmall(),
            socialLogins(),
            mySizedBoxMedium(),
            Column(
              children: [
                Text("Don't have an account?", style: Theme.of(context).textTheme.titleMedium),
                mySizedBoxSmall(),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signUp'),
                    child: Text("REGISTER",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Row socialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.facebook, color: Colors.red, size: IconSizes.medium),
        mySizedBoxSmall(),
        Icon(Icons.telegram, color: Colors.red, size: IconSizes.medium),
        mySizedBoxSmall(),
        Icon(Icons.reddit, color: Colors.red, size: IconSizes.medium),
      ],
    );
  }

  Widget emailField(double width) {
    return SizedBox(
        width: width,
        child: MyTextFieldWidget(
            validatorCallback: ((value) {
              if (value!.isEmpty) {
                return "email can't be null";
              } else {
                return null;
              }
            }),
            controller: viewModel.getEmailController,
            labelText: 'Email'));
  }

  Widget passwordField(double width) {
    return SizedBox(
      width: width,
      child: MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "password can't be null";
          } else {}
          return null;
        }),
        controller: viewModel.getPasswordController,
        labelText: 'Password',
        isSecure: true,
      ),
    );
  }
  //   Widget emailField(double width) {
  //   return SizedBox(
  //     width: width,
  //     child: MyFormFields().emailTextFormField(
  //         validatorCallback: ((value) {
  //           if (value!.isEmpty) {
  //             return "email can't be null";
  //           } else {
  //             return null;
  //           }
  //         }),
  //         controller: viewModel.getEmailController),
  //   );
  // }

  // Widget passwordField(double width) {
  //   return SizedBox(
  //     width: width,
  //     child: MyFormFields().passwordTextFormField(
  //         validatorCallback: ((value) {
  //           if (value!.isEmpty) {
  //             return "password can't be null";
  //           } else {}
  //           return null;
  //         }),
  //         controller: viewModel.getPasswordController),
  //   );
  // }

  Row projectNameTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.play_arrow, size: IconSizes.large, color: Colors.red),
        Text(
          'Movie',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 80,
                color: Colors.white,
                fontFamily: 'Limelight',
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Center signInButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            viewModel.login(context);
          }
          // signIn(context);
        },
        child: MyButtonWidget(
          context: context,
          height: 50,
          width: 350,
          label: "LOG IN",
          onPressed: () {
            viewModel.login(context);
          },
        ),
      ),
    );
  }
}



// class BackgroundImage extends StatelessWidget {
//   const BackgroundImage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (bounds) => const LinearGradient(
//         colors: [Colors.black, Colors.black12],
//         begin: Alignment.bottomCenter,
//         end: Alignment.center,
//       ).createShader(bounds),
//       blendMode: BlendMode.darken,
//       child: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/movie_app_login_screen.png'),
//             fit: BoxFit.cover,
//             colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
//           ),
//         ),
//       ),
//     );
//   }
// }
