import 'package:custodia_parents/pages/signup.dart';
import 'package:custodia_parents/services/auth_services.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'main_screen.dart';
import 'reset_verification.dart';

TextEditingController _usernameInputController = new TextEditingController();
TextEditingController _passwordInputController = new TextEditingController();
TextEditingController _resetEmailInputController = new TextEditingController();

bool verif_resp = false;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14, top: 10),
          child: LoginBody(),
        ),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String userLogin;
  String userPassowrd;
  bool _isPassObscured = true;
  String mResponse = "";

  Color activeColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(42),
              child: Image.asset(
                'assets/images/family.png',
                height: 400,
                width: 400,
                fit: BoxFit.cover,
              ),
            ),
            Opacity(
              opacity: 0.7,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(42),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [UIColors.primary_a, UIColors.primary_b]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        /*Image.asset(
                          '',
                          height: 100,
                          width: 100,
                        ),*/
                      ],
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 30, left: 20),
                          child: Text(
                            'Custodia.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 42.0,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 28.0,
        ),
        Column(
          children: [
            Material(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: UIColors.primaryTextFieldBackground,
              child: TextField(
                textInputAction: TextInputAction.next,
                onChanged: (val) {
                  setState(() => userLogin = val);
                },
                enableInteractiveSelection: true,
                controller: _usernameInputController,
                cursorColor: UIColors.primary_a,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                  border: InputBorder.none,
                  hintText: "Email",
                  prefixIcon: Icon(
                    FeatherIcons.user,
                    color: UIColors.primary_a,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: UIColors.primaryTextFieldBackground,
              child: TextField(
                textInputAction: TextInputAction.next,
                onChanged: (val) {
                  setState(() => userPassowrd = val);
                },
                enableInteractiveSelection: true,
                controller: _passwordInputController,
                obscureText: _isPassObscured ? true : false,
                cursorColor: UIColors.primary_a,
                maxLines: 1,
                decoration: InputDecoration(
                    suffixIcon: FlatButton(
                      onPressed: () {
                        setState(() {
                          _isPassObscured = !_isPassObscured;
                        });
                      },
                      child: Text(
                        _isPassObscured ? 'SHOW' : 'HIDE',
                        style: TextStyle(
                            color: UIColors.primary_a,
                            fontWeight: FontWeight.w600,
                            fontSize: 11),
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                    border: InputBorder.none,
                    hintText: "password",
                    prefixIcon: Icon(
                      FeatherIcons.lock,
                      color: UIColors.primary_a,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      await AuthServices.loginUser(
                        _usernameInputController.text.toString(),
                        _passwordInputController.text.toString(),
                      ).then((value) {
                        mResponse = value;
                      });
                      if (mResponse == "login") {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => MainScreen()));
                      } else {
                        print("err login");
                      }
                    },
                    color: UIColors.primary_a,
                    child: new Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 14.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _resetPasswordBottomSheet(context);
                  },
                  child: Text(
                    'forgot password?',
                    style: TextStyle(
                        color: Colors.blue[700], fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Spacer(),
                GestureDetector(
                  onLongPressStart: (val) {
                    setState(() {
                      activeColor = UIColors.primary_a;
                    });
                  },
                  onLongPressEnd: (val) {
                    setState(() {
                      activeColor = Colors.black;
                    });
                  },
                  onTapUp: (val) {
                    setState(() {
                      activeColor = Colors.black;
                    });
                  },
                  onTap: () {
                    setState(() {
                      activeColor = UIColors.primary_a;
                    });
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Signup()));
                  },
                  child: Row(
                    children: [
                      Text("SIGN UP",
                          style: TextStyle(
                              color: activeColor, fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 6.0,
                      ),
                      Icon(
                        FeatherIcons.arrowRightCircle,
                        color: activeColor,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

void _resetPasswordBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            height: 256.0,
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 14.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      FeatherIcons.unlock,
                      color: Colors.black87,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Forgot your login password?',
                      style: TextStyle(color: Colors.black87),
                    ),
                    Spacer(),
                    CloseButton(
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: UIColors.primaryTextFieldBackground,
                        child: TextField(
                          enableInteractiveSelection: true,
                          controller: _resetEmailInputController,
                          cursorColor: UIColors.primary_a,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 15.0),
                            border: InputBorder.none,
                            hintText: "your login e-mail",
                            prefixIcon: Icon(
                              FeatherIcons.atSign,
                              color: UIColors.primary_a,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        onPressed: () async {
                          verif_resp =
                              await AuthServices.sendLoginMailToResetPassword(
                                  "anis.bejaoui@esprit.tn");

                          if (verif_resp == true) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ResetCodeVerification()));
                          } else {
                            print("bad");
                          }
                          /*verif_resp == true ? print('ok') : print("bad");
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      ResetCodeVerification()));*/
                        },
                        color: UIColors.primary_a,
                        child: new Text(
                          "SEND RESET CODE",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26.0,
                ),
              ],
            ),
          ),
        );
      });
}
