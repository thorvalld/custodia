import 'dart:convert';

import 'package:custodia_parents/models/message.dart';
import 'package:http/http.dart' as http;

class MessengerServices {
  static const String url = 'http://127.0.0.1:8000/msgs';
  static Future<List<Message>> getMsgs(String from, String to) async {
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
  }
}
