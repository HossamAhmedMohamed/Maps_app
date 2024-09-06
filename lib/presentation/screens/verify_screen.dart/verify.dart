// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, sort_child_properties_last, non_constant_identifier_names, avoid_types_as_parameter_names, must_be_immutable, avoid_print, avoid_unnecessary_containers, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/constants/my_color.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/logic/phone_auth_cubit/cubit/phone_cubit.dart';
import 'package:maps_app/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key, required this.phoneNumber});

  final phoneNumber;
  late String otpCode;

  void showProgressIndicator(BuildContext context) {
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

  Widget buildPhoneVerifiedBloc() {
    return BlocListener<PhoneCubit, PhoneState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, State) {
        if (State is Loading) {
          showProgressIndicator(context);
        }
        if (State is PhoneOtpVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapScreen);
        }
        if (State is ErrorOcurred) {
          Navigator.pop(context);
          String errorMsg = (State).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
          ));
        }
      },
      child: Container(),
    );
  }

  Widget buildPinCode(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          borderWidth: 1,
          activeColor: MyColors.blue,
          inactiveColor: MyColors.blue,
          inactiveFillColor: Colors.white,
          activeFillColor: MyColors.lightBlue,
          selectedColor: MyColors.blue,
          selectedFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (code) {
          otpCode = code;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }

  void login(BuildContext context) {
    BlocProvider.of<PhoneCubit>(context).submitOTP(otpCode);
  }

  Widget verifybutton(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            showProgressIndicator(context);
            login(context);
          },
          child: Text(
            "verify",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          style: ElevatedButton.styleFrom(
              minimumSize: Size(100.w, 40.h),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r))),
        ));
  }

  Widget buildIntroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verify your phone number ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 22.sp),
        ),
        SizedBox(height: 18.h),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 2.h),
            child: RichText(
                text: TextSpan(
                    text: "Enter your 6 digit code numbers sent to ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.4),
                    children: <TextSpan>[
                  TextSpan(
                      text: "$phoneNumber",
                      style: TextStyle(color: MyColors.blue)),
                ])))
      ],
    );
  }

   Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your phone number',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digit code numbers sent to ',
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.4),
              children: <TextSpan>[
                TextSpan(
                  text: '$phoneNumber',
                  style: TextStyle(color: MyColors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 88.h),
            child: Column(
              children: [
                buildIntroText(),
                SizedBox(
                  height: 88.h,
                ),
                buildPinCode(context),
                SizedBox(height: 60),
                verifybutton(context),
                buildPhoneVerifiedBloc()

              ],
            ),
          ),
        ),
      ),
    );
  }
}
