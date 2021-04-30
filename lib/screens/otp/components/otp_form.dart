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
  final _formKey = GlobalKey<FormState>();
  var code;
  final List<String> errors = [];
  final codeController = new TextEditingController();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCodeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              // if all are valid then go to success screen
              _handleOtp();
            },
          ),
        ],
      ),
    );
  }

  void _handleOtp() async {
    code = codeController.text;
    var data = {'code': code};

    var res = await CallApi().otp(data, 'auth/2fa/login');
    var body = json.decode(res.body);

    if (body['success']) {
      var data = body['data'];
      var token = data['jwtToken'];
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', token);
      print('$token');
      KeyboardUtil.hideKeyboard(context);
      Navigator.pushNamed(context, LoginSuccessScreen.routeName);
    }
  }

  TextFormField buildCodeFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => code = newValue,
      controller: codeController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCodeNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCodeNullError);
          return "";
        }
        return null;
      },
    );
  }
}
