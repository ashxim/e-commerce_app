part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartUpdated extends CartState {
  final List<Product> cartItems;

  const CartUpdated({required this.cartItems});
}
