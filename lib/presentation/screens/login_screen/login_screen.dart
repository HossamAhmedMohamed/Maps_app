// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, prefer_interpolation_to_compose_strings, must_be_immutable, non_constant_identifier_names, avoid_types_as_parameter_names, sort_child_properties_last, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/constants/my_color.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/logic/phone_auth_cubit/cubit/phone_cubit.dart';
import 'package:maps_app/main.dart';
import 'package:maps_app/presentation/screens/login_screen/widgets/contry-flag.dart';
import 'package:maps_app/presentation/screens/login_screen/widgets/text_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  late String phoneNumber;

  Future<void> register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  Widget nextbutton(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            showProgressIndicator(context);
            register(context);
          },
          child: Text(
            "Next",
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

  Widget buildFieldPhone() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.lightGrey),
                borderRadius: BorderRadius.all(Radius.circular(6.r)),
              ),
              child: Text(
                generateCountryFlag() + '  +20',
                style: TextStyle(fontSize: 16.sp, letterSpacing: .0),
              ),
            )),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
            flex: 2,
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                ),
                child: TextFormField(
                  autofocus: true,
                  style: TextStyle(fontSize: 18, letterSpacing: 2.0),
                  decoration: InputDecoration(border: InputBorder.none),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your phone number ";
                    } else if (value.length < 11) {
                      return "Must be 11";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                )))
      ],
    );
  }

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

  Widget buildPhoneNumberSubmittedBloc() {
    return BlocListener<PhoneCubit, PhoneState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, State) {
        if (State is Loading) {
          showProgressIndicator(context);
        }
        if (State is PhoneNumberSubmitted) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
              key: _phoneFormKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 88.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildText(),
                    SizedBox(
                      height: 100.h,
                    ),
                    buildFieldPhone(),
                    SizedBox(
                      height: 60.h,
                    ),
                    nextbutton(context),
                    buildPhoneNumberSubmittedBloc()
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
