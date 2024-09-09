// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unused_import, sized_box_for_whitespace, sort_child_properties_last, must_be_immutable, prefer_const_constructors_in_immutables, use_build_context_synchronously, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maps_app/constants/my_color.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/logic/phone_auth_cubit/cubit/phone_cubit.dart';
import 'package:path/path.dart' show basename;
import 'dart:io';
import 'dart:math';

class Information extends StatefulWidget {
  Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  PhoneCubit phoneCubit = PhoneCubit();
  final GlobalKey<FormState> _fieldFormKey = GlobalKey();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  File? imgPath;
  String? imgName;

  uploadImage2Screen(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        size: 30,
                        color: MyColors.lightBlue,
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        "Choose From Camera",
                        style:
                            TextStyle(fontSize: 20, color: MyColors.lightBlue),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_outlined,
                        size: 30,
                        color: MyColors.lightBlue,
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        "Choose From Gallery",
                        style:
                            TextStyle(fontSize: 20, color: MyColors.lightBlue),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What about you?',
          style: TextStyle(
              color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Please enter your information to verify your account',
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.4),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCameraIcon() {
    return imgPath == null
        ? Center(
            child: IconButton(
            onPressed: () {
              showmodel();
            },
            icon: Icon(
              Icons.add_a_photo_outlined,
              color: MyColors.blue,
              size: 70,
            ),
          ))
        : InkWell(
            onTap: () {
              showmodel();
            },
            child: ClipOval(
              child: Image.file(
                imgPath!,
                width: 145,
                height: 145,
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  Widget buildTextField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
          ),
          child: TextFormField(
            autofocus: true,
            controller: firstNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: "First Name",
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your first name";
              } else if (value.length < 3) {
                return "At least 3 Characters";
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
          ),
          child: TextFormField(
            autofocus: true,
            controller: lastNameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: "Last Name",
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter your last name";
              } else if (value.length < 3) {
                return "At least 3 Characters";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget buildText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: RichText(
          text: TextSpan(
              text: "By registering you agree to ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.4),
              children: <TextSpan>[
            TextSpan(
                text: "Terms & Conditions ",
                style: TextStyle(color: MyColors.blue)),
            TextSpan(text: "and ", style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "Privacy Policy ",
                style: TextStyle(color: MyColors.blue)),
            TextSpan(text: "of the app", style: TextStyle(color: Colors.black)),
          ])),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void showProgressIndicator() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  Widget buildButton() {
    return ElevatedButton(
      onPressed: () async {
        showProgressIndicator();
        if (!_fieldFormKey.currentState!.validate()) {
          Navigator.pop(context);
          return;
        } else {
          Navigator.pop(context);
          _fieldFormKey.currentState!.save();
          await phoneCubit.sendInfoToDataBase(firstNameController.text,
              lastNameController.text, imgName, imgPath);
          if (!mounted) {
            return;
          }
          Navigator.pushReplacementNamed(context, doneScreen);
        }
      },
      child: Text(
        "Get Started",
        style: TextStyle(color: Colors.white, fontSize: 17),
      ),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 40.h),
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.r))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _fieldFormKey,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 65.h),
                child: Column(
                  children: [
                    _buildIntroTexts(),
                    SizedBox(
                      height: 60,
                    ),
                    buildCameraIcon(),
                    SizedBox(
                      height: 70,
                    ),
                    buildTextField(),
                    SizedBox(
                      height: 80,
                    ),
                    buildText(),
                    SizedBox(
                      height: 30,
                    ),
                    buildButton()
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
