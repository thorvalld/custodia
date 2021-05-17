import 'package:carousel_slider/carousel_slider.dart';
import 'package:custodia_parents/models/device_data.dart';
import 'package:custodia_parents/models/user.dart';
import 'package:flutter/material.dart';
import 'exports.dart';

List<Widget> childrenCards = [
  ChildDashCard(
    child: User(
        fullname: "Arthur",
        avatarUrl: "assets/images/c1.png",
        birthDate: "July 8th, 2008",
        email: "arthur@mail.com",
        credits: 280,
        deviceData: DeviceData(
          isWifiActive: true,
          isSoundActive: true,
          isLocationActive: true,
          batteryLevel: 50,
          runtime: 6,
        )),
  ),
  ChildDashCard(
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
  ChildDashCard(
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
  ChildDashCard(
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
  ),
];

class ChildrenCardsSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChildrenCardsSliderState();
  }
}

class _ChildrenCardsSliderState extends State<ChildrenCardsSlider> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: childrenCards,
      options: CarouselOptions(
          autoPlay: true,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          //aspectRatio: 2,
          enlargeStrategy: CenterPageEnlargeStrategy.height),
      carouselController: _controller,
    );
  }
}
