import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:e_commerce_real/view_model/bloc/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_real/view_model/bloc/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.2),
            child: const Text(
              'My Cart',
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Ionicons.arrow_back)),
        ),
        body: Column(children: [
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is InitialState) {
                  return const Center(child: Text('Your cart is empty'));
                } else if (state is CartUpdated) {
                  final cartItems = state.cartItems;

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = cartItems[index];
                        return Dismissible(
                          onDismissed: (DismissDirection direction) {
                            context
                                .read<CartCubit>()
                                .removeFromCart(product.copyWith(quantity: 0));
                          },
                          key: UniqueKey(),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.accentColor.withOpacity(0.5),
                              ),
                              height: 130,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      width: screenWidth * 0.35,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              product.thumbnail,
                                            ),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Text(
                                              product.title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              textScaleFactor: 0.8,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        ' \$${product.price}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.2,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  color:
                                                      AppColors.kprimaryColor,
                                                )),
                                            alignment: Alignment.bottomRight,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<CartCubit>()
                                                          .reduceQuantity(
                                                              product);
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Ionicons.remove,
                                                      color: AppColors
                                                          .kprimaryColor,
                                                    )),
                                                Text(
                                                  ' ${product.quantity}',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<CartCubit>()
                                                          .addToCart(product);
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Ionicons.add,
                                                      color: AppColors
                                                          .kprimaryColor,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(child: Text('No Item added yet !'));
                }
              },
            ),
          ),
          Builder(
            builder: (BuildContext context) {
              final cartCubit = context.read<CartCubit>();
              final total = cartCubit.calculateTotal();
              return Container(
                padding: const EdgeInsets.only(
                    top: 35, bottom: 20), // Remove const here
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 20), // Remove const here
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '\$$total',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                        backgroundColor: const MaterialStatePropertyAll(
                            AppColors.kprimaryColor), // Remove const here
                        foregroundColor: const MaterialStatePropertyAll(
                            AppColors.background), // Remove const here
                        fixedSize: MaterialStatePropertyAll(
                            Size(screenWidth * 0.9, 50)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Pay Now',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ]));
  }
}
