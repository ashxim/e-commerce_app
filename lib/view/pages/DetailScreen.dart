import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_real/model/products_model.dart';
import 'package:e_commerce_real/view/pages/Cart_page.dart';
import 'package:e_commerce_real/view_model/bloc/cubit/cart/cart_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  final Product product;
  String title;
  String description;
  int price;
  double rating;
  int stock;
  String brand;
  List<String> images;
  String category;

  DetailScreen({
    super.key,
    required this.product,
    required this.category,
    required this.title,
    required this.brand,
    required this.description,
    required this.price,
    required this.rating,
    required this.stock,
    required this.images,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final PageController _pageController = PageController();

  double _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar:
            AppBar(elevation: 0, backgroundColor: Colors.transparent, actions: [
          IconButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ));
          }, icon: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartUpdated) {
                // Access the cart quantity from the CartUpdated state
                return Stack(
                  children: [
                    const Icon(
                      Ionicons.bag_outline,
                      color: Colors.black,
                      size: 25,
                    ),
                    if (state.cartItems.isNotEmpty)
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                              height: 25,
                              width: 12,
                              padding: const EdgeInsets.all(2.0),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                  '${state.cartItems.length}', // Display cart item count
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  )))),
                  ],
                );
              } else {
                // Default behavior if not in CartUpdated state
                return const IconButton(
                  icon: Icon(
                    Ionicons.bag_outline,
                    color: Colors.black,
                    size: 25,
                  ),
                  onPressed: null, // Disable icon if there's no cart data
                );
              }
            },
          ))
        ]),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60)),
                    color: AppColors.accentColor,
                    gradient: RadialGradient(colors: [
                      AppColors.accentColor.withOpacity(0.1),
                      AppColors.textPrimary.withOpacity(0.1)
                    ])),
                child: SizedBox(
                  height: 380,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    itemCount: widget.images.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page.toDouble();
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              DotsIndicator(
                dotsCount: widget.images.length,
                position: _currentPage.toInt(),
                decorator: DotsDecorator(
                  activeColor: AppColors.ksecondaryColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary.withOpacity(0.8)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      itemSize: 18,
                      initialRating: widget.product.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      onRatingUpdate: (value) => print(value),
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${widget.price}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          widget.stock.toString() + 'in Stock',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('About',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.brand,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary.withOpacity(0.8)),
                        ),
                        Text(
                          '||',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary.withOpacity(0.8)),
                        ),
                        Text(
                          widget.category.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary.withOpacity(0.8)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<CartCubit>().addToCart(
                                widget.product.copyWith(quantity: 1));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              animation: CurvedAnimation(
                                  parent: const AlwaysStoppedAnimation(
                                      BorderSide.strokeAlignOutside),
                                  curve: Curves.easeInCirc),
                              content: Text(
                                  '${widget.product.title} added to cart!'),
                              duration: const Duration(milliseconds: 300),
                            ));
                          },
                          style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(
                                  Size(screenWidth * 0.45, 50)),
                              backgroundColor: const MaterialStatePropertyAll(
                                AppColors.accentColor,
                              )),
                          child: const Row(
                            children: [
                              Text(
                                'Add To Cart',
                                style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Icon(
                                Ionicons.cart_sharp,
                                color: AppColors.textPrimary,
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(
                                  Size(screenWidth * 0.45, 50)),
                              backgroundColor: const MaterialStatePropertyAll(
                                  AppColors.kprimaryColor)),
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.backColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ])));
  }
}
