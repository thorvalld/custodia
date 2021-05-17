import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MapTracker extends StatefulWidget {
  @override
  _MapTrackerState createState() => _MapTrackerState();
}

class _MapTrackerState extends State<MapTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          FeatherIcons.arrowLeft,
          color: Colors.black87,
        ),
        title: Text(
          "TRACK CHILDREN",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/previewmap.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 14, right: 14, bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  //background color of box
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    /*offset: Offset(
                      15.0, // Move to right 10  horizontally
                      15.0, // Move to bottom 10 Vertically
                    ),*/
                  )
                ],
              ),
              height: 130,
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "My Children",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          radius: 23.0,
                          child: Image.asset("assets/images/c1.png"),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 23.0,
                          child: Image.asset("assets/images/c2.png"),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 23.0,
                          child: Image.asset("assets/images/c3.png"),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 23.0,
                          child: Image.asset(
                            "assets/images/c4.png",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
