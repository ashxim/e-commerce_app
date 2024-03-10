import 'package:e_commerce_real/view/pages/DetailScreen.dart';
import 'package:e_commerce_real/view/widgets/product_grid.dart';
import 'package:e_commerce_real/view_model/bloc/products_bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Ctegories extends StatelessWidget {
  final String category;
  const Ctegories({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.15),
            child: Text(
              '$category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return BlocBuilder<ProdctsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ProductsLoaded) {
                  final product = state.products
                      .where((product) => product.category == category)
                      .toList();
                  return GridView.builder(
                    itemCount: product.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      // Check if the product belongs to the selected category
                      if (product[index].category == category) {
                        return SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                    product: product[index],
                                    category: product[index].category,
                                    title: product[index].title,
                                    brand: product[index].brand,
                                    description: product[index].description,
                                    price: product[index].price,
                                    rating: product[index].rating,
                                    stock: product[index].stock,
                                    images: product[index].images,
                                  ),
                                ),
                              );
                            },
                            child: ProductHome(
                              title: product[index].title,
                              price: product[index].price,
                              thumbnail: product[index].thumbnail,
                              discountPercentage:
                                  product[index].discountPercentage,
                            ),
                          ),
                        );
                      } else {
                        // Return an empty container if the product doesn't belong to the selected category
                        return const Center(
                          child: Text(
                              'there is no item available in this category currently'),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Error'),
                  );
                }
              },
            );
          },
        ));
  }
}
