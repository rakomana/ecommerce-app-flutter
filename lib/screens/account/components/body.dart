import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_shop/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_shop/screens/sign_up/sign_up_screen.dart';


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
          AccountMenu(
            text: "Login",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(context, SignInScreen.routeName),
            },
          ),
          AccountMenu(
            text: "Signup",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(context, SignUpScreen.routeName),
            },
          ),
          AccountMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {
              _launchURL();
            },
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
