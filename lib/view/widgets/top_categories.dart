import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  final IconData iconData;
  const TopCategories({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 10),
        child: ElevatedButton(
            onPressed: () {},
            child: Icon(
              iconData,
              size: 25,
            ),
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                backgroundColor:
                    MaterialStatePropertyAll(AppColors.accentColor),
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return AppColors.kprimaryColor;
                  return null; // <-- Splash color
                }),
                iconColor: MaterialStatePropertyAll(AppColors.textPrimary))));
  }
}
