import 'package:device_preview/device_preview.dart';
import 'package:e_commerce_real/view/pages/introduction%20pages/Login_page.dart';
import 'package:e_commerce_real/view_model/bloc/cubit/cart/cart_cubit.dart';
import 'package:e_commerce_real/view_model/bloc/cubit/search_cubit.dart';
import 'package:e_commerce_real/view_model/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:e_commerce_real/view_model/bloc/products_bloc/products_bloc.dart';
import 'package:e_commerce_real/view_model/repository/repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final ProdctsBloc productsBloc = ProdctsBloc(ProductsRepository())
    ..add(GetProductsList());
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(
        productsBloc: productsBloc,
        repository: ProductsRepository(),
        cartCubit: CartCubit(),
      ), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  final ProdctsBloc productsBloc;
  final ProductsRepository repository;
  final CartCubit cartCubit;

  const MyApp(
      {super.key,
      required this.productsBloc,
      required this.repository,
      required this.cartCubit});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProdctsBloc>(create: (context) => productsBloc),
          BlocProvider<FavouriteBloc>(create: (context) => FavouriteBloc()),
          BlocProvider<ProductFilterCubit>(
            create: (context) => ProductFilterCubit(
              // Access the repository from the provided instance
              repository,
            ),
          ),
          BlocProvider<CartCubit>(create: (context) => CartCubit())
        ],
        child: MaterialApp(
          scrollBehavior: AppScrollBehavior(),
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
        ));
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.trackpad,
      };
}
