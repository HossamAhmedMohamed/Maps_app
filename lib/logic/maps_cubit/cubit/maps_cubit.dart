// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/data/models/place.dart';
import 'package:maps_app/data/models/place_directions.dart';
import 'package:meta/meta.dart';
import 'package:maps_app/data/models/PlaceSuggestions.dart';
import 'package:maps_app/data/repository/maps_repo.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;
  MapsCubit(
    this.mapsRepository,
  ) : super(MapsInitial());

  void emitPlaceSuggestions(String place, String sessionToken) {
    mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapsRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }

  void emitPlaceDirections(LatLng origin, LatLng destination) {
    mapsRepository.getDirections(origin, destination).then((directions) {
      emit(DirectionsLoaded(directions));
    });
  }
}
