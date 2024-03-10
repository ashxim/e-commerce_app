import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:e_commerce_real/model/constants/datacall.dart';

import 'package:e_commerce_real/view/pages/Cart_page.dart';
import 'package:e_commerce_real/view/pages/DetailScreen.dart';
import 'package:e_commerce_real/view/pages/categories.dart';
import 'package:e_commerce_real/view/widgets/ads_home.dart';
import 'package:e_commerce_real/view/widgets/product_grid.dart';
import 'package:e_commerce_real/view_model/bloc/cubit/cart/cart_cubit.dart';

import 'package:e_commerce_real/view_model/bloc/products_bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const Text(
                    'Hello Hakim',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.waving_hand_rounded,
                    color: AppColors.kprimaryColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.38,
                    ),
                  ),
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
                            Icon(
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
                          onPressed:
                              null, // Disable icon if there's no cart data
                        );
                      }
                    },
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.58,
              ),
              child: const Text('Let’s start shopping!'),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  Item currentItem = itemList[index];
                  return AdsHome(
                    item: currentItem,
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: DataCall().icons.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                          color: AppColors.textSecondary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ctegories(
                                    category: DataCall().categories[index]),
                              ));
                        },
                        child: Image.asset(
                          DataCall().icons[index],
                          width: 30, // Set the width and height as needed
                          height: 20,
                        ),
                      ),
                    ),
                  ),

                  // Add more ListTile properties or actions as needed
                )),
            BlocBuilder<ProdctsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsError) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Text(
                          'error data!',
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  );
                } else if (state is ProductsLoaded) {
                  final products = state.products;
                  return GridView.builder(
                      itemCount: products.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => DetailScreen(
                                            product: products[index],
                                            category: products[index].category,
                                            title: products[index].title,
                                            brand: products[index].brand,
                                            description:
                                                products[index].description,
                                            price: products[index].price,
                                            rating: products[index].rating,
                                            stock: products[index].stock,
                                            images: products[index].images,
                                          )));
                            },
                            child: ProductHome(
                              title: products[index].title,
                              price: products[index].price,
                              thumbnail: products[index].thumbnail,
                              discountPercentage:
                                  products[index].discountPercentage,
                            ),
                          ),
                        );
                      });
                } else {
                  return const Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: CircularProgressIndicator.adaptive());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
