import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final int maxLines;
  final Function onChanged;
  final Function onTapped;

  const TextFieldWidget(
      {@required this.hintText,
      this.textInputType,
      this.onTapped,
      this.obscureText = false,
      this.controller,
      this.maxLines,
      this.prefixIcon,
      this.textInputAction,
      this.onChanged});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      color: UIColors.primaryTextFieldBackground,
      child: TextField(
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        onTap: widget.onTapped,
        enableInteractiveSelection: true,
        cursorColor: UIColors.primary_a,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
        ),
        controller: widget.controller,
        maxLines: widget.maxLines,
      ),
    );
  }
}
