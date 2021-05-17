import 'dart:async';
import 'dart:io';

import 'package:custodia_parents/components/textfield_widget.dart';
import 'package:custodia_parents/models/user.dart';
import 'package:custodia_parents/pages/signin.dart';
import 'package:custodia_parents/services/auth_services.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:password_strength/password_strength.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';

import 'main_screen.dart';

TextEditingController _passwordInputController = new TextEditingController();
TextEditingController _fullnameInputController = new TextEditingController();
TextEditingController _emailInputController = new TextEditingController();
TextEditingController _phoneInputController = new TextEditingController();
TextEditingController _dateInputController = new TextEditingController();
TextEditingController _confirmPasswordInputController =
    new TextEditingController();

double calculatedStrength = 0.0;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 14.0, right: 14.0),
                child: RegisterBody())));
  }
}

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  File _image;
  final picker = ImagePicker();

  ImagePicker imagePicker;

  bool termsChecked = false;
  bool isMatched = false;
  Timer passwordTypingTimer;
  Color activeColor = Colors.black;
  String registerCheck = "";

  String userResgisterEmail = '';
  String userRegisterPassword = '';

  DateTime selectedDate = DateTime.now();
  int selectedBirthDateTimestamp;

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

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "Sign up",
              style: TextStyle(
                  color: UIColors.primary_a,
                  fontSize: 48.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          height: 24.0,
        ),
        Column(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: UIColors.primary_a,
                    child: InkResponse(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 58,
                        backgroundColor: UIColors.primaryTextFieldBackground,
                        //backgroundImage: Image.file(_image),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.file(
                                  _image,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fitHeight,
                                ))
                            : Icon(
                                FeatherIcons.user,
                                color: UIColors.primaryTextColor,
                                size: 46.0,
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 26.0,
            ),
            _buildFullName(),
            SizedBox(
              height: 12.0,
            ),
            _buildEmail(),
            SizedBox(
              height: 12.0,
            ),
            _buildPhone(),
            SizedBox(
              height: 12.0,
            ),
            _buildDateField(),
            SizedBox(
              height: 12,
            ),
            _buildPassword(),
            SizedBox(
              height: 6.0,
            ),
            Row(
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: _passwordInputController.text.toString().isEmpty
                        ? 0.0
                        : calculatedStrength,
                    progressColor: calculatedStrength <= 0.3
                        ? Colors.red
                        : calculatedStrength <= 0.7
                            ? Colors.orange
                            : Colors.green,
                    backgroundColor: UIColors.primaryTextFieldBackground,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    animation: true,
                    animationDuration: 500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            _buildConfirmPassword(),
            SizedBox(
              height: 6.0,
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
              height: 24.0,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        termsChecked = !termsChecked;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(termsChecked
                            ? FeatherIcons.checkSquare
                            : FeatherIcons.square),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text("I agree to Costudia's terms & conditions.")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          onPressed: () async {
                            if (termsChecked &&
                                _fullnameInputController.text.isNotEmpty &&
                                _emailInputController.text.isNotEmpty &&
                                _passwordInputController.text.isNotEmpty &&
                                _confirmPasswordInputController
                                    .text.isNotEmpty) {
                              User newParent = User(
                                  fullname:
                                      _fullnameInputController.text.toString(),
                                  email: _emailInputController.text.toString(),
                                  phoneNumber:
                                      _phoneInputController.text.toString(),
                                  password:
                                      _passwordInputController.text.toString(),
                                  birthDate: '$selectedBirthDateTimestamp');
                              await AuthServices.signupNewUser(newParent)
                                  .then((value) => {registerCheck = value});
                              if (registerCheck == "email") {
                                print("email exists");
                              } else if (registerCheck == "phone") {
                                print("phone exists");
                              } else if (registerCheck == "created") {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => MainScreen()));
                              } else {
                                print("err register ");
                              }
                              //print('ok');
                            }
                          },
                          color: termsChecked &&
                                  _fullnameInputController.text.isNotEmpty &&
                                  _emailInputController.text.isNotEmpty &&
                                  _passwordInputController.text.isNotEmpty &&
                                  _confirmPasswordInputController
                                      .text.isNotEmpty
                              ? UIColors.primary_a
                              : UIColors.primaryTextColor,
                          //borderRadius: new BorderRadius.circular(30.0),
                          child: new Text(
                            "SIGN UP",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26.0,
            ),
            Row(
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Spacer(),
                GestureDetector(
                  onTapCancel: () {
                    setState(() {
                      activeColor = Colors.black;
                    });
                  },
                  onTapUp: (val) {
                    setState(() {
                      activeColor = Colors.black;
                    });
                  },
                  onTapDown: (val) {
                    setState(() {
                      activeColor = UIColors.primary_a;
                    });
                  },
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
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => SignIn()));
                  },
                  child: Row(
                    children: [
                      Text("LOG IN",
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
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildEmail() {
    return TextFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: "E-Mail",
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      controller: _emailInputController,
      prefixIcon: Icon(
        FeatherIcons.atSign,
        color: UIColors.primary_a,
      ),
      maxLines: 1,
    );
  }

  Widget _buildPhone() {
    return TextFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: "Phone number",
      obscureText: false,
      textInputType: TextInputType.number,
      controller: _phoneInputController,
      prefixIcon: Icon(
        FeatherIcons.smartphone,
        color: UIColors.primary_a,
      ),
      maxLines: 1,
    );
  }

  Widget _buildDateField() {
    return TextFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: "Date of birth",
      obscureText: false,
      textInputType: TextInputType.number,
      controller: _dateInputController,
      prefixIcon: Icon(
        FeatherIcons.calendar,
        color: UIColors.primary_a,
      ),
      maxLines: 1,
      onTapped: () {
        _selectDate(context);
      },
    );
  }

  /*Widget _buildDatePicker() {
    return TextFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: "Phone number",
      obscureText: false,
      textInputType: TextInputType.number,
      controller: _phoneInputController,
      prefixIcon: Icon(
        FeatherIcons.smartphone,
        color: UIColors.primary_a,
      ),
      maxLines: 1,
    );
  }*/

  Widget _buildFullName() {
    return TextFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: "Full name",
      obscureText: false,
      textInputType: TextInputType.text,
      controller: _fullnameInputController,
      prefixIcon: Icon(
        FeatherIcons.user,
        color: UIColors.primary_a,
      ),
      maxLines: 1,
    );
  }

  Widget _buildPassword() {
    return TextFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: "Password",
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
      hintText: "Confirm password",
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String yyyy = selectedDate.year.toString();
        String mm = selectedDate.month.toString();
        String dd = selectedDate.day.toString();
        String newFormatting = mm + "/" + dd + "/" + yyyy;
        _dateInputController.text = newFormatting;
        selectedBirthDateTimestamp = selectedDate.millisecondsSinceEpoch;
      });
  }
}
