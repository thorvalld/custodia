import 'dart:math';

import 'package:custodia_parents/components/exports.dart';
import 'package:custodia_parents/models/device_data.dart';
import 'package:custodia_parents/models/user.dart';
import 'package:custodia_parents/pages/add_child.dart';
import 'package:custodia_parents/pages/games/games_home.dart';
import 'package:custodia_parents/pages/giftshop.dart';
import 'package:custodia_parents/pages/map_view.dart';
import 'package:custodia_parents/pages/tasks.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'dart:math' as math;

//List<Child> kids = children;
Random random = new Random();
int randBg = random.nextInt(2);

//background-image: linear-gradient( 109.6deg,  rgba(39,142,255,1) 11.2%, rgba(98,113,255,0.78) 100.2% );

List<Widget> gridItems = [
  GridItem(
    meunItemName: "TASKMASTER",
    menuItemImagePath: "assets/images/notes.png",
    cardColorA: UIColors.lightBlue,
    //cardColorB: UIColors.card_3b,
  ),
  GridItem(
    meunItemName: "QUIZ",
    menuItemImagePath: "assets/images/quiz.png",
    cardColorA: UIColors.card_b,
    //cardColorB: UIColors.card_5b,
  ),
  GridItem(
    meunItemName: "GIFT SHOP",
    menuItemImagePath: "assets/images/shop.png",
    cardColorA: UIColors.card_c,
    //cardColorB: UIColors.card_4b,
  ),
  GridItem(
    meunItemName: "GAMES",
    menuItemImagePath: "assets/images/gaming.png",
    cardColorA: UIColors.card5,
    //cardColorB: UIColors.card_2b,
  ),
  GridItem(
    meunItemName: "SENTRY",
    menuItemImagePath: "assets/images/map.png",
    cardColorA: UIColors.card_e,
    //cardColorB: UIColors.card_1b,
  ),
  GridItem(
    meunItemName: "EXPERIENCE AR",
    menuItemImagePath: "assets/images/ar.png",
    cardColorA: UIColors.card3,
    //cardColorB: UIColors.card_1b,
  ),
];

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Head(),
                SizedBox(
                  height: 26,
                ),
                //ChildrenCardsSlider(),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "CUSTODIA CENTER",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: UIColors.primary_a,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      itemCount: gridItems.length,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              index == 0
                                  ? Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => TaskScreen()))
                                  : index == 1
                                      ? Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => GiftShop()))
                                      : index == 2
                                          ? Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      GiftShop()))
                                          : index == 3
                                              ? Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          GameCenter()))
                                              : index == 4
                                                  ? Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              MapTracker()))
                                                  : Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              MapTracker()));
                            },
                            child: gridItems[index]);
                      },
                      staggeredTileBuilder: (index) {
                        return StaggeredTile.fit(index.isEven ? 2 : 2);
                      }),
                ),
                SizedBox(
                  height: 38,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "MY CHILDREN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: UIColors.primary_a,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                ChildrenProfilesCarousel(),
                /*SizedBox(
                  height: 24,
                ),*/
                //HomeGridMenu(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
class HomeGridMenu extends StatefulWidget {
  @override
  _HomeGridMenuState createState() => _HomeGridMenuState();
}

class _HomeGridMenuState extends State<HomeGridMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 14),
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => TaskScreen()));
              },
              child: GridItem(
                meunItemName: "TASKS",
                menuItemImagePath: "assets/images/notes.png",
                cardColorA: Colors.blueGrey[50],
                cardColorB: Colors.blueGrey[50],
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {},
              child: GridItem(
                meunItemName: "QUIZ",
                menuItemImagePath: "assets/images/quiz.png",
                cardColorA: Colors.blueGrey[50],
                cardColorB: Colors.blueGrey[50],
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => GiftShop()));
              },
              child: GridItem(
                meunItemName: "GIFT SHOP",
                menuItemImagePath: "assets/images/shop.png",
                cardColorA: Colors.blueGrey[50],
                cardColorB: Colors.blueGrey[50],
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => GameCenter()));
              },
              child: GridItem(
                meunItemName: "GAME CENTER",
                menuItemImagePath: "assets/images/gaming.png",
                cardColorA: Colors.blueGrey[50],
                cardColorB: Colors.blueGrey[50],
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => MapTracker()));
              },
              child: GridItem(
                meunItemName: "GAME CENTER",
                menuItemImagePath: "assets/images/map.png",
                cardColorA: Colors.blueGrey[50],
                cardColorB: Colors.blueGrey[50],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
class ChildrenProfilesCarousel extends StatefulWidget {
  @override
  _ChildrenProfilesCarouselState createState() =>
      _ChildrenProfilesCarouselState();
}

class _ChildrenProfilesCarouselState extends State<ChildrenProfilesCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      padding: EdgeInsets.only(left: 14),
      child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
        ChildMainCard(
          //channel: IOWebSocketChannel.connect('ws://10.0.2.2:4000/ws'),
          sender: "anis@mail.com",

          child: User(
              fullname: "Arthur",
              avatarUrl: "assets/images/c1.png",
              //birthDate: "July 8th, 2008",
              email: "arthur@mail.com",
              credits: 280,
              deviceData: DeviceData(
                isWifiActive: false,
                isSoundActive: false,
                isLocationActive: false,
                batteryLevel: 0,
                runtime: 6,
              )),
        ),
        /*ChildMainCard(
              child: User(
                  fullname: "Philip",
                  avatarUrl: "assets/images/c2.png",
                  birthDate: "May 7th, 2012",
                  email: "philip@mail.com",
                  credits: 109,
                  deviceData: DeviceData(
                    isWifiActive: true,
                    isSoundActive: false,
                    isLocationActive: true,
                    batteryLevel: 20,
                    runtime: 12,
                  )),
            ),
            ChildMainCard(
              child: User(
                  fullname: "Astrid",
                  avatarUrl: "assets/images/c3.png",
                  birthDate: "May 12th, 2010",
                  email: "astrid@mail.com",
                  credits: 130,
                  deviceData: DeviceData(
                    isWifiActive: true,
                    isSoundActive: true,
                    isLocationActive: false,
                    batteryLevel: 90,
                    runtime: 3,
                  )),
            ),
            ChildMainCard(
              child: User(
                  fullname: "Lillith",
                  avatarUrl: "assets/images/c4.png",
                  birthDate: "March 2nd, 2015",
                  email: "lilith@mail.com",
                  credits: 67,
                  deviceData: DeviceData(
                    isWifiActive: true,
                    isSoundActive: true,
                    isLocationActive: true,
                    batteryLevel: 70,
                    runtime: 9,
                  )),
            ),*/
        _addChild(context)
      ]),
    );
  }

  Widget _addChild(context) {
    return Container(
        height: 250,
        width: 190,
        child: Center(
          child: InkResponse(
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => AddChild()));
            },
            child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  FeatherIcons.plus,
                  size: 26,
                  color: Colors.grey[500],
                )),
          ),
        ));
  }
}
