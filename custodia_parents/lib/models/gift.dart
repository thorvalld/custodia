List<Gift> gifts = [
  Gift(
    giftTitle: "Rubix cube",
    creditPts: 20,
    imgPath: "assets/images/err.png",
    category: Category.TOYS,
  ),
  Gift(
    giftTitle: "Lego set",
    creditPts: 45,
    imgPath: "assets/images/err.png",
    category: Category.TOYS,
  ),
  Gift(
    giftTitle: "Bicycle",
    creditPts: 110,
    imgPath: "assets/images/err.png",
    category: Category.TOYS,
  ),
  Gift(
    giftTitle: "Doll",
    creditPts: 15,
    imgPath: "assets/images/err.png",
    category: Category.TOYS,
  ),
  Gift(
    giftTitle: "Car-toy",
    creditPts: 15,
    imgPath: "assets/images/err.png",
    category: Category.TOYS,
  ),
  Gift(
    giftTitle: "Jacket",
    creditPts: 32,
    imgPath: "assets/images/err.png",
    category: Category.CLOTHING,
  ),
  Gift(
    giftTitle: "Cosplay",
    creditPts: 76,
    imgPath: "assets/images/err.png",
    category: Category.CLOTHING,
  ),
  Gift(
    giftTitle: "Shirt",
    creditPts: 54,
    imgPath: "assets/images/err.png",
    category: Category.CLOTHING,
  ),
  Gift(
    giftTitle: "Soccer shoes",
    creditPts: 234,
    imgPath: "assets/images/err.png",
    category: Category.CLOTHING,
  ),
  Gift(
    giftTitle: "Smartphone",
    creditPts: 250,
    imgPath: "assets/images/err.png",
    category: Category.TECH,
  ),
  Gift(
    giftTitle: "Playstation 4",
    creditPts: 400,
    imgPath: "assets/images/err.png",
    category: Category.TECH,
  ),
  Gift(
    giftTitle: "Minecraft",
    creditPts: 90,
    imgPath: "assets/images/err.png",
    category: Category.TECH,
  ),
  Gift(
    giftTitle: "DahDah",
    creditPts: 67,
    imgPath: "assets/images/err.png",
    category: Category.CLOTHING,
  ),
  Gift(
    giftTitle: "Carthage Land",
    creditPts: 100,
    imgPath: "assets/images/err.png",
    category: Category.CLOTHING,
  ),
  Gift(
    giftTitle: "Park",
    creditPts: 64,
    imgPath: "assets/images/err.png",
    category: Category.CLOTHING,
  ),
];

class Gift {
  final String giftTitle;
  final int creditPts;
  final String imgPath;
  final Category category;
  final String parentEmail;

  Gift(
      {this.giftTitle,
      this.creditPts,
      this.imgPath,
      this.category,
      this.parentEmail});
}

enum Category { TOYS, CLOTHING, TECH, ACTIVITIES }
