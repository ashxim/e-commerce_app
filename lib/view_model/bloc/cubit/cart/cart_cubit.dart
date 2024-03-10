import 'package:bloc/bloc.dart';
import 'package:e_commerce_real/model/products_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final List<Product> _cartItems = [];
  void addToCart(Product product) {
    final existingProductIndex =
        _cartItems.indexWhere((item) => item.id == product.id);

    if (existingProductIndex == -1) {
      // Product not found in cart, add it with quantity 1
      _cartItems.add(product.copyWith(quantity: 1));
    } else {
      // Product already exists in cart, increment the quantity
      _cartItems[existingProductIndex] = _cartItems[existingProductIndex]
          .copyWith(quantity: _cartItems[existingProductIndex].quantity + 1);
    }

    emit(CartUpdated(cartItems: _cartItems));
  }

  void reduceQuantity(Product product) {
    final productIndex = _cartItems.indexWhere((item) => item.id == product.id);
    if (productIndex != -1 && _cartItems[productIndex].quantity >= 2) {
      _cartItems[productIndex] = _cartItems[productIndex]
          .copyWith(quantity: _cartItems[productIndex].quantity - 1);
      emit(CartUpdated(cartItems: _cartItems));
    }
  }

  void removeFromCart(Product product) {
    final productIndex = _cartItems.indexWhere((item) => item.id == product.id);
    if (productIndex != -1) {
      if (product.quantity == 0) {
        _cartItems.removeAt(productIndex);
      } else {
        _cartItems[productIndex] = product;
      }
      emit(CartUpdated(cartItems: _cartItems));
    }
  }

  double calculateTotal() {
    return _cartItems.fold(
        0.0, (sum, product) => sum + (product.price * product.quantity));
  }

  void clearCart() {
    _cartItems.clear();
    emit(CartUpdated(cartItems: _cartItems));
  }
}
