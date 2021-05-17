import 'package:custodia_parents/components/exports.dart';
import 'package:custodia_parents/models/gift.dart';
import 'package:custodia_parents/utils/UIColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:random_color/random_color.dart';

RandomColor _randomColor = RandomColor();

class GiftShop extends StatefulWidget {
  @override
  _GiftShopState createState() => _GiftShopState();
}

class _GiftShopState extends State<GiftShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 14, left: 14, right: 14),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Head(),
              SizedBox(
                height: 24,
              ),
              Expanded(child: ItemsDisplay())
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String categoryImgPath;
  final Function onTapped;
  final bool isSelected;

  const CategoryButton({this.categoryImgPath, this.onTapped, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      fillColor:
          isSelected ? UIColors.primary_a : UIColors.primaryTextFieldBackground,
      constraints: BoxConstraints.tightFor(
        width: 82,
        height: 82,
      ),
      child: Image.asset(
        categoryImgPath,
        height: 46,
        width: 46,
      ),
      onPressed: onTapped,
      elevation: 0,
      highlightElevation: 0,
    );
  }
}

class ItemsDisplay extends StatefulWidget {
  @override
  _ItemsDisplayState createState() => _ItemsDisplayState();
}

class _ItemsDisplayState extends State<ItemsDisplay> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        itemCount: gifts.length,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 4,
        itemBuilder: (context, index) {
          Color _color =
              _randomColor.randomColor(colorBrightness: ColorBrightness.light);
          return GiftCard(
            index: index,
            bgc: _color,
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(2, index.isEven ? 3 : 2);
        });
  }
}

class GiftCard extends StatelessWidget {
  final int index;
  final Color bgc;

  const GiftCard({this.index, this.bgc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgc,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Icon(
                  CupertinoIcons.gift,
                  size: 20,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  gifts[index].giftTitle,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 13.0,
                  backgroundColor: Colors.orange,
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.money_dollar_circle,
                            color: UIColors.primary_a,
                            size: 16,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            gifts[index].creditPts.toString(),
                            style: TextStyle(
                                color: UIColors.primary_a, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.money_dollar_circle,
                      color: UIColors.primary_a,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      gifts[index].creditPts.toString(),
                      style: TextStyle(color: UIColors.primary_a),
                    ),
                  ],
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
