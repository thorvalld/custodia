import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  String from;
  String to;
  String content;

  Message(this.from, this.to, this.content);

  factory Message.fromJson(dynamic json) {
    return Message(json['from'] as String, json['to'] as String,
        json['content'] as String);
  }

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "content": content,
      };

  @override
  String toString() {
    return '{ ${this.from}, ${this.to}, ${this.content} }';
  }

  bool isFromMe(String myEmail) {
    if (this.from == myEmail) {
      return true;
    } else {
      return false;
    }
  }
}
