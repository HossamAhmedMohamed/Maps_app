// ignore_for_file: unused_import, prefer_const_constructors, must_be_immutable, deprecated_member_use, avoid_unnecessary_containers, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_app/constants/my_color.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/logic/phone_auth_cubit/cubit/phone_cubit.dart';
import 'package:maps_app/main.dart';
import 'package:maps_app/shared/get_data.dart';
import 'package:maps_app/shared/user_image_from_database.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  PhoneCubit phoneCubit = PhoneCubit();

  

  Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          // child: Image.asset(
          //   "assets/images/avatar.png",
          //   fit: BoxFit.cover,
          // ),
          child: ImgUser(),
        ),

        GetUserName(documentId: phoneCubit.getLoggedInuser().uid),
        SizedBox(
          height: 5.h,
        ),
        BlocProvider<PhoneCubit>(
          create: (context) => phoneCubit,
          child: Text(
            "${phoneCubit.getLoggedInuser().phoneNumber}",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget buildDrawerListItem({
    required IconData leadingIcon,
    required String title,
    Widget? trailing,
    Function()? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= Icon(
        Icons.arrow_right,
        color: MyColors.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  void launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'could not launch $url';
  }

  Widget buildIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => launchURL(url),
      child: Icon(
        icon,
        color: MyColors.blue,
        size: 35.sp,
      ),
    );
  }

  Widget buildSocialMediaIcons() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.w),
      child: Row(
        children: [
          buildIcon(FontAwesomeIcons.facebook,
              'https://www.facebook.com/profile.php?id=100006470908958'),
          SizedBox(
            width: 15.w,
          ),
          buildIcon(FontAwesomeIcons.linkedin,
              'https://www.linkedin.com/in/hossam-ahmed-581b10257/'),
          SizedBox(
            width: 15.w,
          ),
          buildIcon(
              FontAwesomeIcons.github, 'https://github.com/HossamAhmedMohamed'),
        ],
      ),
    );
  }

  Widget buildLogOutBlocProvider(context) {
    return Container(
      child: BlocProvider<PhoneCubit>(
        create: (context) => phoneCubit,
        child: buildDrawerListItem(
            leadingIcon: Icons.logout,
            title: 'Logout',
            onTap: () async {
              await phoneCubit.logOut();
              Navigator.of(context).pushReplacementNamed(loginScreen);
            },
            color: Colors.red,
            trailing: SizedBox()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          Container(
            height: 255.h,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          
          buildDrawerListItem(leadingIcon: Icons.person, title: "My Profile"),
          buildDrawerListItemsDivider(),

          buildDrawerListItem(leadingIcon: Icons.history, title: "Places history"),
          buildDrawerListItemsDivider(),

          buildDrawerListItem(leadingIcon: Icons.settings, title: "Settings"),
          buildDrawerListItemsDivider(),

          buildDrawerListItem(leadingIcon: Icons.help, title: "Help"),
          buildDrawerListItemsDivider(),

          buildLogOutBlocProvider(context),

          SizedBox(height: 60.h,),

        ListTile(

            leading: Text("Follow Us" , 
            style: TextStyle(color: Colors.grey[600]),),
              ),

              buildSocialMediaIcons(),

            ],
          
          
        
      ),
    );
  }
}
