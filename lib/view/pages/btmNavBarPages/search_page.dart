import 'dart:async';

import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:e_commerce_real/view/pages/DetailScreen.dart';
import 'package:e_commerce_real/view_model/bloc/cubit/search_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rxdart/rxdart.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  late final StreamController<String> _searchController;
  @override
  void initState() {
    super.initState();
    context.read<ProductFilterCubit>().loadProducts();
    _searchController = StreamController<String>();

    _searchController.stream
        .debounceTime(const Duration(milliseconds: 200))
        .listen((String value) {
      context.read<ProductFilterCubit>().filterByName(value);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _searchController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.13),
          child: const Text(
            'Look for your product',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SearchBar(
              overlayColor: MaterialStatePropertyAll(
                  AppColors.textPrimary.withOpacity(0.2)),
              textStyle: MaterialStatePropertyAll(
                  TextStyle(color: Colors.black87.withOpacity(0.7))),
              onChanged: (String value) {
                _searchController.add(value);
              },
              padding:
                  const MaterialStatePropertyAll(EdgeInsets.only(left: 15)),
              leading: Icon(
                Ionicons.search_outline,
                color: AppColors.kprimaryColor.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<ProductFilterCubit, ProductFilterState>(
                  builder: (context, state) {
                if (state is ErrorState) {
                  return Center(child: Text('Error: ${state.error}'));
                }

                if (state is LoadedState) {
                  final products = state.products;

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  product: products[index],
                                  category: products[index].category,
                                  title: products[index].title,
                                  brand: products[index].brand,
                                  description: products[index].description,
                                  price: products[index].price,
                                  rating: products[index].rating,
                                  stock: products[index].stock,
                                  images: products[index].images,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: AppColors.accentColor.withOpacity(0.5),
                            ),
                            height: 130,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Image.network(
                                  products[index].thumbnail,
                                  height: 120,
                                  width: screenWidth * 0.35,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          products[index].title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          textScaleFactor: 0.9,
                                        ),
                                        Text(
                                          '\$${products[index].price}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is LoadingState) {
                  return const Center(
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballClipRotateMultiple,

                          /// Required, The loading type of the widget
                          colors: [
                            AppColors.ksecondaryColor,
                            AppColors.kprimaryColor,
                          ],

                          /// Optional, The color collections
                          strokeWidth: 2,

                          /// Optional, The stroke of the line, only applicable to widget which contains line

                          /// Optional, Background of the widget
                          pathBackgroundColor: Colors.black

                          /// Optional, the stroke backgroundColor
                          ));
                }

                // Return an empty container if none of the conditions are met
                return Container();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
