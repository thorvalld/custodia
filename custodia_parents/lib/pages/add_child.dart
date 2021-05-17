import 'package:custodia_parents/components/textfield_widget.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

TextEditingController _fullnameInputController = new TextEditingController();
TextEditingController _phoneInputController = new TextEditingController();

String qrhash = "";

class AddChild extends StatefulWidget {
  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(left: 14.0, right: 14.0),
                child: AddChildBody())));
  }
}

class AddChildBody extends StatefulWidget {
  @override
  _AddChildBodyState createState() => _AddChildBodyState();
}

class _AddChildBodyState extends State<AddChildBody> {
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
              "Add child",
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
        Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: UIColors.primary_a,
                child: CircleAvatar(
                  radius: 58,
                  backgroundColor: UIColors.primaryTextFieldBackground,
                  child: Icon(
                    FeatherIcons.user,
                    color: UIColors.primaryTextColor,
                    size: 46.0,
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
        _buildPhone(),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            Expanded(
              child: CupertinoButton(
                onPressed: () {
                  String name = _fullnameInputController.text.toString();
                  String phone = _phoneInputController.text.toString();
                  setState(() {
                    qrhash = name + ";" + phone;
                    if (_fullnameInputController.text.isEmpty ||
                        _phoneInputController.text.isEmpty) {
                      qrhash = "";
                    }
                  });
                },
                color: UIColors.primary_a,
                //borderRadius: new BorderRadius.circular(30.0),
                child: Row(
                  children: [
                    new Icon(CupertinoIcons.person_add),
                    new SizedBox(
                      width: 14,
                    ),
                    new Text(
                      "CREATE CHILD PROFILE",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Color(0xffACC8E5).withOpacity(0.4),
              borderRadius: BorderRadius.circular(14)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: qrhash == ""
                  ? Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/barcode.png",
                            height: 128,
                            width: 128,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "your child's secure QR\nis not generated yet",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          QrImage(
                            data: qrhash,
                            size: 200,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Color(0xff112A46),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "your child's secure QR\nis ready to be scanned\nuse Custodia kids to LOGIN",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ))
      ],
    );
  }
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

Widget _buildFullName() {
  return TextFieldWidget(
    textInputAction: TextInputAction.next,
    hintText: "Name",
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
