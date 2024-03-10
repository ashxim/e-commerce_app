import 'package:bloc/bloc.dart';

import 'package:e_commerce_real/view/widgets/product_grid.dart';
import 'package:equatable/equatable.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteState()) {
    on<AddToFavouritesEvent>((event, emit) {
      final currentFavourites = state.favourites;
      final newFavourites = event.status == FavoriteStatus.favorite
          ? (List.of(currentFavourites)..add(event.product))
          : currentFavourites.where((p) => p != event.product).toList();
      emit(FavouriteState(favourites: newFavourites));
    });
  }
}
