import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/api/auth.dart';
import 'package:flutter_shop/components/default_button.dart';
import 'package:flutter_shop/size_config.dart';
import 'package:flutter_shop/helper/keyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shop/screens/login_success/login_success_screen.dart';

import '../../../constants.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String otp_1;
  String otp_2;
  String otp_3;
  String otp_4;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  onSaved: (newValue) => otp_1 = newValue,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  onSaved: (newValue) => otp_2 = newValue,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  onSaved: (newValue) => otp_3 = newValue,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  onSaved: (newValue) => otp_4 = newValue,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () {
              _handleOtp();
            },
          )
        ],
      ),
    );
  }

  void _handleOtp() async {
    String code = otp_1 + otp_2 + otp_3 + otp_4;
    var data = {'code': code};

    var res = await CallApi().otp(data, 'auth/2fa/login');
    var body = json.decode(res.body);

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['jwtToken']);
      localStorage.setString('user', json.encode(body['user']));

      KeyboardUtil.hideKeyboard(context);
      Navigator.pushNamed(context, LoginSuccessScreen.routeName);
    }
  }
}
