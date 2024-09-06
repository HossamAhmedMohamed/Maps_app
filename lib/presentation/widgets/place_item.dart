// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters, unused_import, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/constants/my_color.dart';

import 'package:maps_app/data/models/PlaceSuggestions.dart';
import 'package:maps_app/presentation/screens/login_screen/login_screen.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({
    Key? key,
    required this.suggestion,
  }) : super(key: key);

  final PlaceSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    var subTitle = suggestion.description
        .replaceAll(suggestion.description.split(',')[0], '');
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),

      decoration: BoxDecoration(color: Colors.white , borderRadius: BorderRadius.circular(8.r)),

      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(color: MyColors.lightBlue , shape: BoxShape.circle),
              child: Icon(Icons.place , color: MyColors.blue,),
            ),
            title: RichText(text: TextSpan(
              children: [
                TextSpan(
                  text: '${suggestion.description.split(',')[0]}\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  )
                ),
                TextSpan(
                  text: subTitle,
                  style: TextStyle(color: Colors.black,
                  fontSize: 16.sp
                  )
                )
              ]
            )),
          )
        ],
      ),

    );
  }
}
