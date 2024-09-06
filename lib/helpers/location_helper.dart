import 'package:geolocator/geolocator.dart';

class LocationHelper {

  static Future<Position> getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled(); // to check if user is turning on location or not //
    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}