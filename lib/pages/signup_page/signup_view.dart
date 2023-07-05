// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/widget/text_field_utils.dart';
import 'package:movie_app/pages/signup_page/signup_cubit.dart';
import 'package:movie_app/pages/signup_page/signup_state.dart';
import 'package:movie_app/utils/theme_utilitys.dart';
import 'package:image_picker/image_picker.dart';
import '../../widget/bg_image_utils.dart';
import '../../widget/button_utils.dart';

class SignupView extends StatefulWidget {
  final SignupCubit viewModel;
  SignupView({super.key, required this.viewModel});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormState>();

  File? _image;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider<SignupCubit>(create: (_) => widget.viewModel, child: _buildScaffold(height, context));
  }

  Widget _buildScaffold(double height, BuildContext context) {
    return Center(
      child: Stack(
        children: [
          BackgroundImage(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [Colors.black, Colors.black54],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ).createShader(bounds);
            },
          ),
          Scaffold(
              // ignore: prefer_const_literals_to_create_immutables
              appBar: AppBar(),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      Navigator.of(context).pushNamed('/logIn');
                    }
                  },
                  builder: (context, state) {
                    debugPrint('Signup view state: $state');
                    if (state is SignupInitial) {
                      return _buildInitial();
                    }
                    // else if( state is SignupLoading){
                    //   _buildLoading();
                    // }else if( state is SignupError){
                    // }
                    return Container();
                  },
                ),
              ))
        ],
      ),
    );
  }

  Center _buildInitial() {
    return Center(
        child: Form(
      key: formKey,
      child: Column(
        children: [
          imageProfile(context),
          mySizedBoxSmall(),
          Text('Add profile picture', style: Theme.of(context).textTheme.titleLarge),
          mySizedBoxMedium(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text('Millions of movies, TV shows and people to discover. Discover now.',
                textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge),
          ),
          mySizedBoxMedium(),
          nameField(width: 350),
          mySizedBoxSmall(),
          surnameField(width: 350),
          mySizedBoxSmall(),
          emailField(width: 350),
          mySizedBoxSmall(),
          passwordField(width: 350),
          mySizedBoxSmall(),
          MyButtonWidget(
            context: context,
            height: 50,
            width: 350,
            label: "SIGN UP",
            onPressed: () {
              widget.viewModel.sigup(context);
            },
          ),
        ],
      ),
    ));
  }

  Widget nameField({required double width}) {
    return SizedBox(
      width: width,
      child: MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "name can't be null";
          } else {}
          return null;
        }),
        controller: widget.viewModel.getNameController,
        labelText: 'Name',
      ),
    );
  }

  Widget surnameField({required double width}) {
    return SizedBox(
      width: width,
      child: MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "surname can't be null";
          } else {}
          return null;
        }),
        controller: widget.viewModel.getSurnameController,
        labelText: 'Surname',
      ),
    );
  }

  Widget emailField({required double width}) {
    return SizedBox(
      width: width,
      child: MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "email can't be null";
          } else {}
          return null;
        }),
        controller: widget.viewModel.getEmailController,
        labelText: 'Email',
      ),
    );
  }

  Widget passwordField({required double width}) {
    return SizedBox(
      width: width,
      child: MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "password can't be null";
          } else {}
          return null;
        }),
        controller: widget.viewModel.getPasswordController,
        labelText: 'Password',
        isSecure: true,
      ),
    );
  }

  // void takePhoto(ImageSource source) async {
  //   final _picker = ImagePicker();
  //   final pickedFile = await _picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  void takePhoto(ImageSource source) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        List<int> imageBytes = _image!.readAsBytesSync();
        widget.viewModel.image = imageBytes;
      });
    }
  }

  Widget imageProfile(BuildContext context) {
    return Stack(
      children: [
        myCircleAvatar(),
        Positioned(
            bottom: 0.0,
            right: 0.0,
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(context: context, builder: ((builder) => bottomSheet(context)));
                },
                child: Icon(Icons.camera_alt_outlined, size: 30, color: Colors.white)))
      ],
    );
  }

  CircleAvatar myCircleAvatar() {
    ImageProvider _avatarDefaultImage = AssetImage('assets/images/default_avatar.png');
    if (_image != null) {
      _avatarDefaultImage = FileImage(File(_image!.path)) as ImageProvider;
    }

    return CircleAvatar(
      backgroundColor: CustomColors.darkGrey,
      radius: 60.0,
      // child: Icon(Icons.person_2, size: IconSizes.large, color: CustomColors.red),
      backgroundImage: _avatarDefaultImage,
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text('Choose profile photo', style: Theme.of(context).textTheme.titleLarge),
          mySizedBoxSmall(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: const Icon(Icons.camera),
                tooltip: 'Camera',
              ),
              IconButton(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.image),
                tooltip: 'Gallery',
              ),
            ],
          )
        ],
      ),
    );
  }
}
