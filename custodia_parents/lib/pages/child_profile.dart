import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ChildProfile extends StatefulWidget {
  @override
  _ChildProfileState createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: ProfileWidget(),
      )),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Header(),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Jacob's to-dos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        TodoWidget(1, 'Shool work: Maths and Physics'),
        SizedBox(
          height: 6,
        ),
        TodoWidget(1, 'Cleaning room'),
        SizedBox(
          height: 18,
        ),
        TodoWidget(2, 'Groceries'),
        SizedBox(
          height: 18,
        ),
        TodoWidget(3, 'Pick up your sister from school'),
      ],
    );
  }
}

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(FeatherIcons.arrowLeft),
        SizedBox(
          width: 12,
        ),
        CircleAvatar(
            radius: 12.0,
            backgroundColor: Colors.purple,
            child: Text(
              "J",
              style: TextStyle(color: Colors.white),
            )),
        SizedBox(
          width: 12,
        ),
        Text("Jacob's profile"),
        Spacer(),
        CircleAvatar(
            radius: 16.0,
            backgroundColor: Colors.orange,
            child: Text(
              "A",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}

class TodoWidget extends StatefulWidget {
  final int level;
  final String task;
  TodoWidget(this.level, this.task);
  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
          ),
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: 12.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0)),
                  color: widget.level == 1
                      ? Colors.green
                      : widget.level == 2
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                '${widget.task}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
