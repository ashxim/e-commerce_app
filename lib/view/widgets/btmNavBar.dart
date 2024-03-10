import 'package:e_commerce_real/model/constants/colors.dart';

import 'package:e_commerce_real/view/pages/btmNavBarPages/MyHomePage.dart';
import 'package:e_commerce_real/view/pages/btmNavBarPages/favourite_page.dart';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../pages/btmNavBarPages/profile_page.dart';
import '../pages/btmNavBarPages/search_page.dart';

class BtmNavBar extends StatefulWidget {
  const BtmNavBar({super.key});

  @override
  State<BtmNavBar> createState() => _BtmNavBarState();
}

class _BtmNavBarState extends State<BtmNavBar> {
  var _selectedIndex = 0;
  final List _pages = [
    const MyHomePage(),
    const FavouritePage(),
    const SearchPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 100,
        child: FlashyTabBar(
          animationDuration: Duration(milliseconds: 250),
          selectedIndex: _selectedIndex,
          onItemSelected: (int i) {
            setState(() {
              _selectedIndex = i;
            });
          },
          items: [
            FlashyTabBarItem(
              icon: const Icon(
                Ionicons.home_outline,
                color: AppColors.textPrimary,
                shadows: [BoxShadow(blurStyle: BlurStyle.outer)],
              ),
              title: Text(
                'Home',
                style:
                    TextStyle(color: AppColors.kprimaryColor.withOpacity(0.8)),
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(
                Ionicons.heart_outline,
                color: AppColors.textPrimary,
              ),
              title: Text('favourite',
                  style: TextStyle(
                      color: Color.fromARGB(255, 240, 8, 8).withOpacity(0.8))),
            ),
            FlashyTabBarItem(
              icon: const Icon(
                Ionicons.search_outline,
                color: AppColors.textPrimary,
              ),
              title: Text('search',
                  style: TextStyle(
                      color: AppColors.ksecondaryColor.withOpacity(0.8))),
            ),
            FlashyTabBarItem(
              icon: const Icon(
                Ionicons.person_outline,
                color: AppColors.textPrimary,
              ),
              title: const Text('profile'),
            )
          ],
        ),
      ),
    );
  }
}
