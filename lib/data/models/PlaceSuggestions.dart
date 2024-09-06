// ignore_for_file: file_names

class PlaceSuggestion {
  late String placeID;
  late String description;

  PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    placeID = json["place_id"];
    description = json["description"];
  }
}
