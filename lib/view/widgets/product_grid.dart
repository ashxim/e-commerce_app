import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:e_commerce_real/view_model/bloc/favourite_bloc/favourite_bloc.dart';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

// ignore: must_be_immutable
class ProductHome extends StatefulWidget {
  final String title;
  final int price;
  final String thumbnail;
  final double discountPercentage;

  const ProductHome({
    super.key,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.discountPercentage,
  });

  @override
  State<ProductHome> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  // Initialize as false
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = ProductHome(
      title: widget.title,
      price: widget.price,
      thumbnail: widget.thumbnail,
      discountPercentage: widget.discountPercentage,
    );
    final FavouriteBloc _favouriteBloc = FavouriteBloc();

    @override
    void initState() {
      super.initState();
      _favouriteBloc.stream.listen((state) {
        setState(() {
          isFavorite = state.favourites.contains(product);
        });
      });
    }

    @override
    void dispose() {
      _favouriteBloc.close(); // Close the bloc when done
      super.dispose();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Container(
        height: 204,
        width: 174,
        decoration: BoxDecoration(
          color: AppColors.accentColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.discountPercentage}% OFF',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _favouriteBloc.add(AddToFavouritesEvent(
                        product: product,
                        status: isFavorite
                            ? FavoriteStatus.notFavorite
                            : FavoriteStatus.favorite)); // Add/remove from bloc
                  },
                  icon: Icon(
                    isFavorite
                        ? Ionicons.heart
                        : Ionicons.heart_outline, // Dynamic icon
                    color: isFavorite
                        ? Colors.red
                        : AppColors.textPrimary, // Dynamic color
                  ),
                ),
              ],
            ),
            Image.network(
              fit: BoxFit.fill,
              widget.thumbnail,
              height: 80,
              width: 120,
            ),
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              "\$${widget.price}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
