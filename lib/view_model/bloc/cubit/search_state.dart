part of 'search_cubit.dart';

abstract class ProductFilterState {
  get product => Product;
}

class InitialState extends ProductFilterState {
  final List<Product> products;

  InitialState(this.products);
}

class LoadingState extends ProductFilterState {}

class LoadedState extends ProductFilterState {
  final List<Product> products;

  LoadedState(this.products);
}

class ErrorState extends ProductFilterState {
  final String error;

  ErrorState({required this.error});
}
