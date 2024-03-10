part of 'favourite_bloc.dart';

class FavouriteState {
  final List<dynamic> favourites;
  FavouriteState({List<dynamic>? favourites}) : favourites = favourites ?? [];
  List<Object?> get props => [favourites];
}
