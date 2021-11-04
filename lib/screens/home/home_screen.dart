import 'package:flutter/material.dart';
import 'package:flutter_shop/components/coustom_bottom_nav_bar.dart';
import 'package:flutter_shop/enums.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.value);

  final String value;
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(value),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
