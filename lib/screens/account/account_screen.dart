import 'package:flutter/material.dart';
import 'package:flutter_shop/components/coustom_bottom_nav_bar.dart';
import 'package:flutter_shop/enums.dart';

import 'components/body.dart';

class AccountScreen extends StatelessWidget {
  static String routeName = "/account";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
