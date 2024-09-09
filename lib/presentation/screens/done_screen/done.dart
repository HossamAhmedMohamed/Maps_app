// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/constants/my_color.dart';
import 'package:maps_app/constants/strings.dart';

class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 88.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.blue),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 100,
                  )),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "You 'are almost done to get ",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Started, lets do it...",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 220),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, mapScreen);
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40.h),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
