// ignore_for_file: unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/main.dart';

Widget buildText() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("What is your phone number ?",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 22.sp
      ),),

      SizedBox(height: 18.h),

      Container(
        margin: EdgeInsets.symmetric(horizontal: 2.h),
        child: Text("Please enter your phone number to verify your account",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 18.sp
        ),),
      )
    ],
  );
}
