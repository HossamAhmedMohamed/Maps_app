// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/data/models/PlaceSuggestions.dart';
import 'package:maps_app/data/models/place.dart';
import 'package:maps_app/data/models/place_directions.dart';
import 'package:maps_app/data/web_services/places_webservices.dart';

class MapsRepository {
  final PlacesWebservices placesWebservices;
  MapsRepository(
    this.placesWebservices,
  );

  Future<List<PlaceSuggestion>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebservices.fetchSuggestion(place, sessionToken);

    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
        await placesWebservices.getPlaceLocation(placeId, sessionToken);
    return Place.fromJson(place);
  }

  Future<PlaceDirections> getDirections(
      LatLng origin, LatLng destination) async {
    final directions =
        await placesWebservices.getDirections(origin, destination);

    return PlaceDirections.fromJson(directions);
  }
}
