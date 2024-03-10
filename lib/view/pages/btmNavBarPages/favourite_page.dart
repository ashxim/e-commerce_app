import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:e_commerce_real/view_model/bloc/favourite_bloc/favourite_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.3),
          child: const Text(
            'My Wishlist',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: BlocBuilder<FavouriteBloc, FavouriteState>(
                  builder: (context, state) {
                if (state.favourites.isEmpty) {
                  return Center(child: const Text("Favourite page is empty"));
                } else {
                  return GridView.custom(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate: SliverWovenGridDelegate.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: state.favourites.length.toDouble(),
                      crossAxisSpacing: state.favourites.length.toDouble(),
                      pattern: [
                        WovenGridTile(
                          5 / 7,
                          crossAxisRatio: 0.9,
                          alignment: AlignmentDirectional.center,
                        ),
                        const WovenGridTile(
                          6 / 7,
                          crossAxisRatio: 0.95,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = state.favourites[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            child: ClipRect(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Image.network(
                                        product.thumbnail,
                                        fit: BoxFit.cover,
                                        height: screenHeight * 0.18,
                                      ),
                                      Text(
                                        product.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.32,
                                        right: screenHeight * 0.3),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Ionicons.heart_circle_outline,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: state.favourites.length,
                    ),
                  );
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
