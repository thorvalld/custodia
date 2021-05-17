import 'package:flutter/material.dart';

class GameCenter extends StatefulWidget {
  @override
  _GameCenterState createState() => _GameCenterState();
}

class _GameCenterState extends State<GameCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 14, left: 14, right: 14),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.all(14),
                color: Colors.red,
                child: Text("tic tac toe"),
              ),
              Container(
                margin: EdgeInsets.all(14),
                color: Colors.red,
                child: Text("chess"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
