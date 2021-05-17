import 'package:custodia_parents/models/user.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChildDashCard extends StatefulWidget {
  final User child;

  const ChildDashCard({this.child});
  @override
  _ChildDashCardState createState() => _ChildDashCardState();
}

class _ChildDashCardState extends State<ChildDashCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.only(top: 14.0, left: 12.0, right: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18.0,
                    backgroundColor: Colors.purple,
                    child: Image.asset(widget.child.avatarUrl),
                  ),
                  SizedBox(width: 12),
                  Text(
                    widget.child.fullname,
                    style: TextStyle(
                        color: UIColors.primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        widget.child.deviceData.isWifiActive
                            ? CupertinoIcons.wifi
                            : CupertinoIcons.wifi_slash,
                        color: widget.child.deviceData.isWifiActive
                            ? Colors.blue
                            : Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        widget.child.deviceData.isLocationActive
                            ? CupertinoIcons.location_fill
                            : CupertinoIcons.location_slash_fill,
                        color: widget.child.deviceData.isLocationActive
                            ? Colors.blue
                            : Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        widget.child.deviceData.isSoundActive
                            ? CupertinoIcons.volume_up
                            : CupertinoIcons.volume_off,
                        color: widget.child.deviceData.isSoundActive
                            ? Colors.green
                            : Colors.red,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        widget.child.deviceData.batteryLevel <= 5
                            ? CupertinoIcons.battery_empty
                            : widget.child.deviceData.batteryLevel <= 25
                                ? CupertinoIcons.battery_25
                                : widget.child.deviceData.batteryLevel <= 80
                                    ? CupertinoIcons.battery_75_percent
                                    : CupertinoIcons.battery_100,
                        color: widget.child.deviceData.batteryLevel <= 5
                            ? Colors.red
                            : widget.child.deviceData.batteryLevel <= 60
                                ? Colors.yellow[900]
                                : Colors.green,
                        size: 18,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "today's screen time (in hrs.)",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 13.0),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CircularPercentIndicator(
                animateFromLastPercent: true,
                restartAnimation: true,
                radius: 75.0,
                lineWidth: 8.0,
                animation: true,
                percent: widget.child.deviceData.runtime / 24,
                center: new Text(
                  widget.child.deviceData.runtime.toString(),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: UIColors.primary_a,
                animationDuration: 3000,
              ),
              /*
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Most used apps",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 13.0),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/tiktok.png',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Image.asset(
                    'assets/images/facebook.png',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Image.asset(
                    'assets/images/instagram.png',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ],
              )
            */
            ],
          ),
        ),
      ),
    );
  }
}
