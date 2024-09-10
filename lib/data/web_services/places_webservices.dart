// ignore_for_file: prefer_const_constructors, unused_import, avoid_print

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/constants/strings.dart';
import 'package:maps_app/data/models/PlaceSuggestions.dart';

class PlacesWebservices {
  late Dio dio;

  PlacesWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> fetchSuggestion(
      String place, String sessionToken) async {
    try {
      Response response = await dio.get(suggestionBaseUrl, queryParameters: {
        'input': place,
        'types': 'address',
        'components': 'country:eg',
        'key': googleAPIKey,
        'sessiontoken': sessionToken,
      });
      return response.data["predictions"];
    } catch (error) {
      return [];
    }
  }

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(placeLocationBaseUrl, queryParameters: {
        'place_id': placeId,
        'fields': 'geometry',
        'key': googleAPIKey,
        'sessiontoken': sessionToken,
      });
      return response.data;
    } catch (error) {
      return Future.error("Place location error :  ",
          StackTrace.fromString(("this is its trace")));
    }
  }

   
  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    try {
      Response response = await dio.get(
        directionsBaseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleAPIKey,
        },
      );
       
      print(response.data);
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
}
