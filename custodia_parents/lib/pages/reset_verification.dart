import 'package:custodia_parents/pages/reset_password.dart';
import 'package:custodia_parents/services/auth_services.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';

String verif_resp_code = "";
String codeInput = "";

class ResetCodeVerification extends StatefulWidget {
  @override
  _ResetCodeVerificationState createState() => _ResetCodeVerificationState();
}

class _ResetCodeVerificationState extends State<ResetCodeVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 14, left: 14, right: 14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  "assets/images/messagesent.png",
                  height: 400,
                  width: 400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter the 4 digit code sent to your E-Mail.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(20.0),
                    child: VerificationCodeInput(
                      keyboardType: TextInputType.text,
                      length: 4,
                      onCompleted: (String value) {
                        //...
                        print(value);
                        codeInput = value;
                      },
                    )),
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
                            verif_resp_code =
                                await AuthServices.checkResetCodeValidity(
                                    codeInput);
                            if (verif_resp_code == "ok code") {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          ResetPasswordScreen()));
                              print(verif_resp_code);
                            } else if (verif_resp_code == "expired code") {
                              print(verif_resp_code);
                            } else if (verif_resp_code == "not found code") {
                              print(verif_resp_code);
                            } else {
                              print("7ata wa7da fihom");
                            }
                          },
                          color: UIColors.primary_a,
                          child: Text(
                            'VERIFY CODE',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(CupertinoIcons.exclamationmark_triangle),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'your verification code will expire in 00:30:00',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
