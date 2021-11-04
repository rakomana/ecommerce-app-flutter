import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  final nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        //onChanged: (value) => print(value),
        controller: nameController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _handleSearch(context);
                })),
      ),
    );
  }

  void _handleSearch(BuildContext context) {
    print(nameController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          nameController.text,
        ),
      ),
    );
  }
}
