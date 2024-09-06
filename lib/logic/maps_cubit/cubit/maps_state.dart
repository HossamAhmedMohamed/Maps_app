part of 'maps_cubit.dart';

@immutable
sealed class MapsState {}

final class MapsInitial extends MapsState {}

class PlacesLoaded extends MapsState {
  final List<PlaceSuggestion> places;

  PlacesLoaded(this.places);
}

class PlaceLocationLoaded extends MapsState {
  final Place place;

  PlaceLocationLoaded(this.place);
}

class DirectionsLoaded extends MapsState {
  final PlaceDirections placeDirections;

  DirectionsLoaded(this.placeDirections);
}
