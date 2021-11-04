

import 'package:flutter/widgets.dart';
import 'package:flutter_shop/screens/cart/cart_screen.dart';
import 'package:flutter_shop/screens/details/details_screen.dart';
import 'package:flutter_shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_shop/screens/home/home_screen.dart';
import 'package:flutter_shop/screens/profile/profile_screen.dart';
import 'package:flutter_shop/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_shop/screens/splash/splash_screen.dart';
import 'package:flutter_shop/screens/account/account_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AccountScreen.routeName: (context) => AccountScreen(),
};