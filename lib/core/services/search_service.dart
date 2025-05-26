import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceSearch {
  final String description;
  final LatLng location;

  PlaceSearch({required this.description, required this.location});
}

class SearchService {
  final String mapboxAccessToken;

  SearchService({required this.mapboxAccessToken});

  Future<List<PlaceSearch>> searchPlaces(String query) async {
    final url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/'
        '$query.json?access_token=$mapboxAccessToken&types=place,address&limit=5';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final features = data['features'] as List;

      return features.map((feature) {
        final coordinates = feature['geometry']['coordinates'];
        return PlaceSearch(
          description: feature['place_name'],
          location: LatLng(coordinates[1], coordinates[0]),
        );
      }).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
