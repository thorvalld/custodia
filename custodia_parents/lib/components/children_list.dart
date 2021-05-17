import 'package:custodia_parents/pages/child_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChildrenListView extends StatefulWidget {
  @override
  _ChildrenListViewState createState() => _ChildrenListViewState();
}

class _ChildrenListViewState extends State<ChildrenListView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ChildElement(),
              SizedBox(
                width: 14,
              ),
              ChildElement(),
              SizedBox(
                width: 14,
              ),
              ChildElement(),
              SizedBox(
                width: 14,
              ),
              ChildElement(),
            ],
          ),
        ),
      ],
    );
  }
}

class ChildElement extends StatefulWidget {
  @override
  _ChildElementState createState() => _ChildElementState();
}

class _ChildElementState extends State<ChildElement> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => ChildProfile()));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 22,
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 6)
              ],
            ),
            child: CircleAvatar(
                radius: 22.0,
                backgroundColor: Colors.purple,
                child: Text(
                  "J",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Jacob',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
