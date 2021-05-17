import 'package:custodia_parents/models/user.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

User loggedInParent = new User(
    fullname: "Anis",
    avatarUrl: "assets/images/p1.png",
    email: "anis@mail.com");

class Head extends StatefulWidget {
  @override
  _HeadState createState() => _HeadState();
}

class _HeadState extends State<Head> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 14, left: 14, right: 14),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              /*Transform.rotate(
                angle: 90 * math.pi / 180,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    FeatherIcons.barChart2,
                    color: UIColors.primaryTextColor,
                  ),
                ),
              ),*/
              Icon(CupertinoIcons.bell),
              SizedBox(
                width: 16,
              ),
              Text(
                'Welcome, ${loggedInParent.fullname}',
                style: TextStyle(color: Colors.green[600], fontSize: 20),
              ),
              Spacer(),
              InkResponse(
                onTap: () {
                  triggerProfileBottomSheet(context);
                },
                child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Colors.orange,
                    child: Image.asset(loggedInParent.avatarUrl)),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                FeatherIcons.info,
                color: UIColors.primaryTextColor,
                size: 18,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'trial period expires in',
                style: TextStyle(color: UIColors.primaryTextColor),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '30 days',
                style: TextStyle(
                    color: UIColors.primaryTextColor,
                    fontWeight: FontWeight.bold),
              ),
              /*SlideCountdownClock(
                duration: Duration(
                  days: 30,
                ),
                slideDirection: SlideDirection.Up,
                separator: ":",
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                shouldShowDays: false,
                onDone: () {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
                },
              ),*/
              Spacer(),
              /*ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {
                  trriggerPremiumBottomsheet(context);
                },
                child: Text(
                  "GO PREMIUM",
                  style: TextStyle(
                      color: UIColors.primary_a, fontWeight: FontWeight.w600),
                ),
              )*/
            ],
          ),
        ],
      ),
    );
  }
}

void trriggerPremiumBottomsheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter stateSetter) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(64.0)),
                  ),
                  margin: EdgeInsets.only(
                      left: 180.0, right: 180.0, top: 8.0, bottom: 14.0),
                  height: 6.0,
                ),
                Image.asset(
                  "assets/images/warning.png",
                  height: 256,
                  width: 256,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "your 30 days trial period has ended.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "thank you for using Custudia. We are letting you know that your free trail has expired and to continue enjoying the benefits of Custodia select a plan and become a PREMIUM MEMBER.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          onPressed: () {
                            print('form submitted!');
                          },
                          color: UIColors.primary_a,
                          child: Text(
                            'CHECK OUR PLANS',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  height: 4.0,
                ),
              ],
            ),
          );
        });
      });
}

void triggerProfileBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter stateSetter) {
          return Container(
            margin: EdgeInsets.only(bottom: 14),
            height: 216,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(64.0)),
                  ),
                  margin: EdgeInsets.only(
                      left: 180.0, right: 180.0, top: 8.0, bottom: 8.0),
                  height: 6.0,
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset(
                    "assets/images/crown.png",
                    height: 30,
                    width: 30,
                  ),
                  title: Text(
                    "Upgrade to a premium member",
                    style: TextStyle(
                        color: UIColors.primaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  trailing: Icon(
                    CupertinoIcons.arrow_right_circle,
                    color: UIColors.primaryTextColor,
                    size: 22,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: UIColors.primaryTextFieldBackground,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 12.0,
                                  backgroundColor: Colors.orange,
                                  child: Image.asset("assets/images/p1.png")),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Profile",
                                style: TextStyle(
                                    color: UIColors.primaryTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: UIColors.primaryTextFieldBackground,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.settings,
                                color: UIColors.primaryTextColor,
                                size: 22,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(
                                    color: UIColors.primaryTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: UIColors.primaryTextFieldBackground,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.info,
                                color: UIColors.primaryTextColor,
                                size: 22,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "About",
                                style: TextStyle(
                                    color: UIColors.primaryTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    FeatherIcons.logOut,
                    color: Colors.red,
                    size: 26,
                  ),
                  title: Text(
                    "Log out",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        });
      });
}
