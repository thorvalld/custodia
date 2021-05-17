import 'dart:async';

import 'package:custodia_parents/components/textfield_widget.dart';
import 'package:custodia_parents/services/auth_services.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:password_strength/password_strength.dart';

TextEditingController _passwordInputController = new TextEditingController();
TextEditingController _confirmPasswordInputController =
    new TextEditingController();

double calculatedStrength = 0.0;
bool resp_pass_reset = false;

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isMatched = false;
  Timer passwordTypingTimer;

  _onChangedHandler(value) {
    const duration = Duration(milliseconds: 300);
    if (passwordTypingTimer != null) {
      setState(() {
        passwordTypingTimer.cancel();
      });
    }
    setState(() {
      passwordTypingTimer = new Timer(duration, () => estimate(value));
    });
  }

  _onChangedConfirmHandler(value) {
    const duration = Duration(milliseconds: 50);
    if (passwordTypingTimer != null) {
      setState(() {
        passwordTypingTimer.cancel();
      });
    }
    setState(() {
      passwordTypingTimer = new Timer(duration, () => match(value));
    });
  }

  estimate(value) {
    calculatedStrength = estimatePasswordStrength(value);
  }

  bool match(value) {
    return value == _passwordInputController.text.toString()
        ? isMatched = true
        : isMatched = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 14, left: 14, right: 14),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/images/resetpass.png",
                height: 400,
                width: 400,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reset your passweord',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 21,
              ),
              _buildPassword(),
              SizedBox(
                height: 8,
              ),
              _buildConfirmPassword(),
              SizedBox(
                height: 12,
              ),
              Visibility(
                visible: _confirmPasswordInputController.text.isEmpty
                    ? false
                    : match(_confirmPasswordInputController.text.toString())
                        ? true
                        : false,
                child: Row(
                  children: [
                    Icon(
                      FeatherIcons.checkCircle,
                      color: Colors.green,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      "Passwords match",
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        onPressed: () async {
                          resp_pass_reset =
                              await AuthServices.confirmPasswordReset(
                                  _passwordInputController.text, "aa");
                          if (resp_pass_reset == true) {
                            print("your password was reset, use your new pass");
                          } else {
                            print("something wrong with pass reset");
                          }
                          //print('form submitted!');
                        },
                        color: UIColors.primary_a,
                        child: Text(
                          'SAVE CHANGES',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return TextFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: "New password",
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      controller: _passwordInputController,
      prefixIcon: Icon(
        FeatherIcons.lock,
        color: UIColors.primary_a,
      ),
      maxLines: 1,
      onChanged: _onChangedHandler,
    );
  }

  Widget _buildConfirmPassword() {
    return TextFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: "Confirm new password",
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      controller: _confirmPasswordInputController,
      prefixIcon: Icon(
        FeatherIcons.lock,
        color: UIColors.primary_a,
      ),
      maxLines: 1,
      onChanged: _onChangedConfirmHandler,
    );
  }
}
