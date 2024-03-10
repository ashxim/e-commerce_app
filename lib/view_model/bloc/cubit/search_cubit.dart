import 'package:bloc/bloc.dart';
import 'package:e_commerce_real/model/products_model.dart';
import 'package:e_commerce_real/view_model/repository/repository.dart';

part 'search_state.dart';

class ProductFilterCubit extends Cubit<ProductFilterState> {
  final ProductsRepository
      _repository; // Use a private field for the repository
  ProductFilterCubit(this._repository) : super(InitialState([]));
  List<Product> totalResults = [];
  ProductFilterState get initialState => InitialState(totalResults);

  void loadProducts() async {
    totalResults = await _repository.fetchProducts();

    emit(LoadedState(totalResults));

    try {
      final products = await _repository.fetchProducts();
      emit(LoadedState(products));
    } on Exception catch (e) {
      emit(ErrorState(error: e.toString())); // Handle errors gracefully
    }
  }

  // Filter/search methods

  void filterByName(String title) {
    print('Filtering by: $title');

    if (title.isEmpty) {
      emit(LoadedState(
          totalResults)); // Emit the original list if the search query is empty
    } else if (state is LoadedState) {
      final loadedState = state as LoadedState;
      final filteredProducts = loadedState.products
          .where((product) =>
              product.title.toLowerCase().contains(title.toLowerCase()))
          .toList();
      print('Filtered products: $filteredProducts');
      emit(LoadedState(filteredProducts));
    } else {
      emit(LoadedState(
          totalResults)); // If state is not LoadedState, emit the original list
    }
  }
}
