import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/api/auth.dart';
import 'package:flutter_shop/constants.dart';
import 'package:flutter_shop/helper/keyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shop/screens/home/home_screen.dart';
import 'package:flutter_shop/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_shop/size_config.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to trolleyway, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "Crazy Prizes around Gauteng",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  void initState() {
    super.initState();
    _checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkAuth(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var res = await CallApi().getUser('user');
    var body = json.decode(res.body);

    if (localStorage.getString('token') != null) {
      if(body['success']) {
        KeyboardUtil.hideKeyboard(context);
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    }
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
