import 'package:custodia_parents/models/user.dart';
import 'package:custodia_parents/pages/messenger.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ChildMainCard extends StatefulWidget {
  final User child;
  final String sender;

  const ChildMainCard({
    this.child,
    this.sender,
  });
  @override
  _ChildMainCardState createState() => _ChildMainCardState();
}

class _ChildMainCardState extends State<ChildMainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(1),
      height: 350,
      width: 370,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 94,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.purple, Colors.blue])),
                        height: 74,
                      ),
                    ),
                    Positioned(
                      top: 42,
                      left: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              radius: 26.0,
                              backgroundColor: Colors.orange,
                              child: Image.asset(widget.child.avatarUrl)),
                          //Spacer(),
                          SizedBox(
                            width: 146,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 3,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      widget.child.deviceData.isWifiActive
                                          ? CupertinoIcons.wifi
                                          : CupertinoIcons.wifi_slash,
                                      color:
                                          widget.child.deviceData.isWifiActive
                                              ? Colors.blue
                                              : Colors.grey,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Icon(
                                      widget.child.deviceData.isLocationActive
                                          ? CupertinoIcons.location_fill
                                          : CupertinoIcons.location_slash_fill,
                                      color: widget
                                              .child.deviceData.isLocationActive
                                          ? Colors.blue
                                          : Colors.grey,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Icon(
                                      widget.child.deviceData.isSoundActive
                                          ? CupertinoIcons.volume_up
                                          : CupertinoIcons.volume_off,
                                      color:
                                          widget.child.deviceData.isSoundActive
                                              ? Colors.green
                                              : Colors.red,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Icon(
                                      widget.child.deviceData.batteryLevel <= 5
                                          ? CupertinoIcons.battery_empty
                                          : widget.child.deviceData
                                                      .batteryLevel <=
                                                  25
                                              ? CupertinoIcons.battery_25
                                              : widget.child.deviceData
                                                          .batteryLevel <=
                                                      80
                                                  ? CupertinoIcons
                                                      .battery_75_percent
                                                  : CupertinoIcons.battery_100,
                                      color: widget.child.deviceData
                                                  .batteryLevel <=
                                              5
                                          ? Colors.red
                                          : widget.child.deviceData
                                                      .batteryLevel <=
                                                  60
                                              ? Colors.yellow[900]
                                              : Colors.green,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.person_fill,
                      size: 18,
                      color: Colors.blue[600],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.child.fullname,
                      style: TextStyle(
                          color: UIColors.primaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(right: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.checkmark_seal_fill,
                            size: 18,
                            color: UIColors.primary_a,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                                color: UIColors.primary_a,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            CupertinoIcons.square_stack_3d_up_fill,
                            size: 18,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '8',
                            style: TextStyle(
                                color: UIColors.primaryTextColor,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.money_dollar_circle,
                      size: 18,
                      color: Colors.yellow[900],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.child.credits.toString(),
                      style: TextStyle(
                          color: UIColors.primaryTextColor,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.tv,
                      size: 18,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "screen time",
                      style: TextStyle(
                          color: UIColors.primaryTextColor,
                          fontWeight: FontWeight.normal),
                    ),
                    Spacer(),
                    Text(
                      "4 hrs.",
                      style: TextStyle(
                          color: UIColors.primaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        //flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          child: CupertinoButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Messenger(
                                            ch: IOWebSocketChannel.connect(
                                                'ws://127.0.0.1:4000/ws'),
                                            se: widget.sender,
                                            de: widget.child.email,
                                          )));
                            },
                            color: UIColors.primary_a,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Icon(CupertinoIcons.chat_bubble_2_fill),
                                new SizedBox(
                                  width: 14,
                                ),
                                new Text(
                                  "MESSAGE",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
