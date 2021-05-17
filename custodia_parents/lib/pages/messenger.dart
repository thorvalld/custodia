import 'dart:convert';

import 'package:custodia_parents/models/message.dart';
import 'package:custodia_parents/models/user.dart';
import 'package:custodia_parents/services/messenger_service.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

TextEditingController _msgTextController = new TextEditingController();
ScrollController _msgScrollingController = new ScrollController();

User child = new User(fullname: "Archur", avatarUrl: "assets/images/c1.png");

class Messenger extends StatefulWidget {
  final WebSocketChannel ch;
  final String se;
  final String de;
  Messenger({
    this.ch,
    this.se,
    this.de,
  });
  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        backgroundColor: UIColors.primary_a,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset(
                "assets/images/c1.png",
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              "Arthur",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: MessengerBody(
        channel: widget.ch,
        sender: widget.se,
        destination: widget.de,
      ),
    );
  }
}

class MessengerBody extends StatefulWidget {
  final WebSocketChannel channel;
  final String sender;
  final String destination;
  final String msgText;

  MessengerBody({this.channel, this.sender, this.destination, this.msgText});
  @override
  _MessengerBodyState createState() => _MessengerBodyState();
}

class _MessengerBodyState extends State<MessengerBody> {
  List<Message> conversation = [];

  @override
  void initState() {
    String message = "{\"from\":\"" +
        widget.sender +
        "\",\"to\":\"" +
        widget.destination +
        "\",\"event\":\"join\"}";
    widget.channel.sink.add(message);

    MessengerServices.getMsgs(widget.sender, widget.destination).then((msgs) {
      setState(() {
        conversation = msgs;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  Message msg = Message.fromJson(jsonDecode(snapshot.data));
                  conversation.add(msg);
                }
                return ListView.builder(
                    itemCount: conversation.length,
                    controller: _msgScrollingController,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: conversation[index],
                        sender: widget.sender,
                      );
                    });
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
            BoxShadow(
              offset: Offset(0, 8),
              blurRadius: 32,
              color: Color(0xff087949).withOpacity(.09),
            )
          ]),
          child: SafeArea(
              child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 12,
                  ),
                  height: 50,
                  decoration: BoxDecoration(
                      color: UIColors.primary_a.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgTextController,
                          cursorColor: UIColors.primary_a,
                          decoration: InputDecoration(
                              hintText: "Type message..",
                              hintStyle: TextStyle(fontSize: 14),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      IconButton(
                        onPressed: () {
                          _sendMsg();
                          setState(() {
                            _msgTextController.text = "";
                          });
                        },
                        /*onPressed: () {
                          _sendMsg();
                          setState(() {
                            _msgTextController.text = "";
                            print('\n--message: ' +
                                _msgTextController.text +
                                "\n--sender: " +
                                widget.sender +
                                "\n--destination: " +
                                widget.destination);
                            print("backend:\n");
                          });
                        },*/
                        icon:
                            Icon(CupertinoIcons.arrowshape_turn_up_right_fill),
                        color: UIColors.primary_a,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        )
      ],
    );
  }

  _sendMsg() {
    if (_msgTextController.text.isNotEmpty) {
      String message = "{\"from\":\"" +
          widget.sender +
          "\",\"to\":\"" +
          widget.destination +
          "\",\"content\":\"" +
          _msgTextController.text +
          "\",\"event\":\"message\"}";
      widget.channel.sink.add(message);
      print(message);
      _msgScrollingController
          .jumpTo(_msgScrollingController.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    String message = "{\"from\":\"" +
        widget.sender +
        "\",\"to\":\"" +
        widget.destination +
        "\",\"event\":\"close\"}";
    widget.channel.sink.add(message);
    widget.channel.sink.close();
    super.dispose();
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    this.message,
    this.sender,
  });

  final Message message;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isFromMe(sender)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              color: message.isFromMe(sender)
                  ? UIColors.primary_a
                  : UIColors.seeBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Text(
            message.content,
            style: TextStyle(
                color:
                    message.isFromMe(sender) ? Colors.white : Colors.black87),
          ),
        ),
      ],
    );
  }
}

class Msg {
  final String text;
  final bool isSender;
  Msg(this.text, this.isSender);
}

List<Msg> myMsgs = [
  Msg("Hei", true),
  Msg("Hallo", false),
  Msg("hvordan går det for du?", true),
  Msg("bare bra, og du?", false),
  Msg("jeg vil bare bra agså, Mange takk", true),
  Msg("takk", false),
  Msg("Ha det", true),
  Msg("Ha det bra", false),
  Msg("Hei", true),
  Msg("Hallo", false),
  Msg("hvordan går det for du?", true),
  Msg("bare bra, og du?", false),
  Msg("jeg vil bare bra agså, Mange takk", true),
  Msg("takk", false),
  Msg("Ha det", true),
  Msg("Ha det bra", false),
  Msg("Hei", true),
  Msg("Hallo", false),
  Msg("hvordan går det for du?", true),
  Msg("bare bra, og du?", false),
  Msg("jeg vil bare bra agså, Mange takk", true),
  Msg("takk", false),
  Msg("Ha det", true),
  Msg("Ha det bra", false),
  Msg("Hei", true),
  Msg("Hallo", false),
  Msg("hvordan går det for du?", true),
  Msg("bare bra, og du?", false),
  Msg("jeg vil bare bra agså, Mange takk", true),
  Msg("takk", false),
  Msg("Ha det", true),
  Msg("Ha det bra", false),
  Msg("Hei", true),
  Msg("Hallo", false),
  Msg("hvordan går det for du?", true),
  Msg("bare bra, og du?", false),
  Msg("jeg vil bare bra agså, Mange takk", true),
  Msg("takk", false),
  Msg("Ha det", true),
  Msg("Ha det bra", false),
];
