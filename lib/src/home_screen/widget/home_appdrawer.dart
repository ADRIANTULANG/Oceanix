import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../messaginglobby_screen/view/messaginglobby_view.dart';
import '../../profile_screen/view/profile_view.dart';
import '../alertdialog/home_alertdialogs.dart';
import '../controller/home_controller.dart';

class HomeAppDrawer {
  static showAppDrawer({required HomeController controller}) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Container(
              height: 15.h,
              width: 100.w,
              child: Image.asset("assets/images/logologin.jpg")),
          SizedBox(
            height: 3.h,
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Get.to(() => ProfileView());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.white,
            ),
            title: Text(
              'Preserving Marine Resources',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Get.to(() => ProfileView());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.message_rounded,
              color: Colors.white,
            ),
            title: Text(
              'Chat',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Get.to(() => MessagingLobyyView());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: Text(
              'Log out',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Get.back();
              HomeAlertdialogs.showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }
}
