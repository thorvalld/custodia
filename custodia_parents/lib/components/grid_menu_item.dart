import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  final String meunItemName;
  final String menuItemImagePath;
  final Color cardColorA;
  final Color cardColorB;
  const GridItem(
      {this.meunItemName,
      this.menuItemImagePath,
      this.cardColorA,
      this.cardColorB});
  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      //height: 52,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.cardColorA,
          /*gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [widget.cardColorA, widget.cardColorB])*/
        ),

        /*--card widget props-- 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: widget.cardColorA,
        elevation: 0,*/
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                widget.menuItemImagePath,
                height: 48,
                width: 48,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                widget.meunItemName,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
