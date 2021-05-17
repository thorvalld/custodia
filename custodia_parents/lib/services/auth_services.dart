import 'dart:convert';

import 'package:custodia_parents/models/user.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

var url = "http://127.0.0.1:8000/";

class AuthServices {
  static Future<String> signupNewUser(User parent) async {
    final http.Response response = await http.post(url + "user",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': parent.email,
          'password': parent.password,
          'fullname': parent.fullname,
          'phone': parent.phoneNumber,
          'birthDate': parent.birthDate,
        }));

    if (response.statusCode == 201) {
      return "created";
    } else if (response.statusCode == 202) {
      return "email";
    } else if (response.statusCode == 203) {
      return "phone";
    } else {
      return "err register: " + response.reasonPhrase.toString();
    }
  }

  static Future<String> loginUser(String email, String password) async {
    String deviceMacAddress = "test-mac";

    final http.Response response = await http.post(url + "login",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'macAddress': deviceMacAddress,
        }));

    if (response.statusCode == 200) {
      return "login";
    } else {
      return "nologin";
    }
  }

  getCurrentUser(String email) async {
    User mUser = new User();
    return mUser;
  }

  static getUserObj(String email) async {
    User mUser;
    final http.Response response = await http.post(url + "getuser",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }));

    if (response.statusCode == 200) {
      mUser = User.fromJson(json.decode(response.body));
    }
    return mUser;
  }

  static Future<bool> sendLoginMailToResetPassword(String userMail) async {
    final http.Response response = await http.post(url + "generateCode/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': userMail,
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> checkResetCodeValidity(String verifCode) async {
    final http.Response response = await http.post(url + "checkSession/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'code': verifCode}));

    if (response.statusCode == 200) {
      return "ok code";
    } else if (response.statusCode == 202) {
      return "expired code";
    } else {
      return "not found code";
    }
  }

  static Future<bool> confirmPasswordReset(
      String password, String userMail) async {
    final http.Response response = await http.post(url + "resetPassword/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'email': userMail, 'password': password}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
