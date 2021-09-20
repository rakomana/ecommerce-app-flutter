import 'dart:convert';
import 'package:flutter_shop/api/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/helper/keyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shop/screens/account/edit_profile.dart';
import 'package:flutter_shop/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_shop/screens/cart/cart_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

import 'package:flutter_shop/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              )
            },
          ),
          ProfileMenu(
            text: "Orders",
            icon: "assets/icons/Cart Icon.svg",
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              )
            },
          ),
          // ProfileMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   press: () {},
          // ),
          // // ProfileMenu(
          // //   text: "Settings",
          // //   icon: "assets/icons/Settings.svg",
          // //   press: () {},
          // // ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {
              _launchURL();
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              _handleLogout(context);
            },
          ),
        ],
      ),
    );
  }

  void _handleLogout(context) async {

    var res = await CallApiAccount().logout('logout');
    var body = json.decode(res.body);

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.clear();

      KeyboardUtil.hideKeyboard(context);
      Navigator.pushNamed(context, SignInScreen.routeName);
    }
  }

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
