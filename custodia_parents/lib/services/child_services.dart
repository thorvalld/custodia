import 'dart:convert';

import 'package:custodia_parents/models/user.dart';
import 'package:http/http.dart' as http;

class ChildServices {
  static const String url = 'http://127.0.0.1:8000/';
  static Future addChild(User child) async {
    final http.Response response = await http.post(url + "child/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'emailParent': child.parentEmail,
          'email': "",
          'password': "",
          'fullname': child.fullname,
          'phone': child.phoneNumber,
          'role': "CHILD",
          'birthDate': child.birthDate,
          'credits': 0
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

  static Future<List> getAllChildren() {}
  /*static Future<List<User>> addChild(String from, String to) async {
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'from': from, 'to': to}));
      if (200 == response.statusCode) {
        final List<Message> msgs = messageFromJson(response.body);
        return msgs;
      } else {
        return List<Message>();
      }
    } catch (e) {
      return List<Message>();
    }
  }*/
}
