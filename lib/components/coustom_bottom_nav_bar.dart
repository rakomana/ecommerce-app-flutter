import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/api/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_shop/screens/home/home_screen.dart';
import 'package:flutter_shop/screens/profile/profile_screen.dart';
import 'package:flutter_shop/screens/account/account_screen.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              // IconButton(
              //   icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
              //   onPressed: () {},
              // ),
              // IconButton(
              //   icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
              //   onPressed: () {},
              // ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    _checkAuth(context),
              ),
            ],
          )),
    );
  }

  _checkAuth(context) async {
    var res = await CallApi().getUser('user');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.pushNamed(context, ProfileScreen.routeName);
    }else{
      Navigator.pushNamed(context, AccountScreen.routeName);
    }
  }
}
