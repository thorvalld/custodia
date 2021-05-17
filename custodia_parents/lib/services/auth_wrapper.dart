import 'package:custodia_parents/models/user.dart';
import 'package:custodia_parents/pages/main_screen.dart';
import 'package:custodia_parents/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userAuthListener = Provider.of<User>(context);
    return userAuthListener == null ? SignIn() : MainScreen();
  }
}
