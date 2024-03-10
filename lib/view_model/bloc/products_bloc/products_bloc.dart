import 'package:bloc/bloc.dart';
import 'package:e_commerce_real/model/products_model.dart';

import 'package:e_commerce_real/view_model/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProdctsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository prodctsRepo;
  List<Product> allProducts = [];
  ProdctsBloc(this.prodctsRepo) : super(ProductsInitial()) {
    on<GetProductsList>((event, emit) async {
      try {
        final products =
            await prodctsRepo.fetchProducts(); // Pass the query parameter
        allProducts = products; // Store all articles in the bloc

        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    });
  }
}
