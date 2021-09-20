import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/helper/keyboard.dart';
import 'package:flutter_shop/components/custom_surfix_icon.dart';
import 'package:flutter_shop/components/default_button.dart';
import 'package:flutter_shop/components/form_error.dart';
import 'package:flutter_shop/components/no_account_text.dart';
import 'package:flutter_shop/size_config.dart';
import 'package:flutter_shop/api/password.dart';
import 'package:flutter_shop/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  List<String> errors = [];

  var email;
  bool isLoading = true;

  final emailController = new TextEditingController();

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
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            controller: emailController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then label text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          isLoading
              ? DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = false;
                      });
                      // call forgot password function to send password reset link
                      _handleForgotPassword();
                    }
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }

  _handleForgotPassword() async {
    email = emailController.text;
    var data = {'email': email};

    var res =
        await CallApiForgotPassword().forgotPassword(data, 'password/email');
    var body = json.decode(res.body);

    if (body['message'] == 'passwords.sent') {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('password reset link sent succesfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, SignInScreen.routeName),
              child: const Text('Go to Login'),
            ),
          ],
        ),
      );

      KeyboardUtil.hideKeyboard(context);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Warning'),
          content: const Text('Something went wrong'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Ok'),
              child: const Text('Go to Login'),
            ),
          ],
        ),
      );

      KeyboardUtil.hideKeyboard(context);
    }
  }
}
