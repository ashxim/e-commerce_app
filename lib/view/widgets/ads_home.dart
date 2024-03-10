import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:flutter/material.dart';

class Item {
  final Color? color;
  final String? text;
  final String? image;

  Item({this.color, this.text, this.image});
}

List<Item> itemList = [
  Item(
      color: AppColors.kprimaryColor,
      text: '20% OFF DURING THE WEEKEND',
      image: 'assets/shop_bag.png'),
  Item(
      color: AppColors.ksecondaryColor,
      text: 'SHOP NOW WITH THE BEST OFFERS',
      image: 'assets/shop_bag.png'),
  Item(
      color: Colors.green,
      text: 'PARTICIPATE TO WIN APPLE PRODUCT',
      image: 'assets/shop_bag.png'),
  // Add more items as needed
];

class AdsHome extends StatelessWidget {
  final Item item;
  AdsHome({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: item.color,
        ),
        width: screenWidth * 0.9,
        height: 150,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Column(
                    children: [
                      Text(
                        item.text!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Get Now'),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.04),
                child: Image.asset(
                  item.image!,
                  height: 140,
                  width: screenWidth * 0.35,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
