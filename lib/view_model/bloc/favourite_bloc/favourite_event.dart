part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {}

enum FavoriteStatus { favorite, notFavorite }

class AddToFavouritesEvent extends FavouriteEvent {
  final ProductHome product;
  final FavoriteStatus status;
  AddToFavouritesEvent({required this.product, required this.status});

  @override
  List<Object?> get props => [product];
}

class RemoveFromFavouritesEvent extends FavouriteEvent {
  final ProductHome product;

  RemoveFromFavouritesEvent(this.product);

  @override
  List<Object?> get props => [product];
}
