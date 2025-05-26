import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteService {
  final String mapboxAccessToken;

  RouteService({required this.mapboxAccessToken});

  Future<Map<String, dynamic>> getRouteCoordinates(
    LatLng start,
    LatLng end,
  ) async {
    final url = 'https://api.mapbox.com/directions/v5/mapbox/driving/'
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}'
        '?alternatives=true'
        '&annotations=distance,duration'
        '&geometries=geojson'
        '&language=en'
        '&overview=full'
        '&steps=true'
        '&access_token=$mapboxAccessToken';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final route = data['routes'][0];
      final coordinates = route['geometry']['coordinates'] as List;

      final List<LatLng> polylineCoords =
          coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();

      return {
        'polyline': polylineCoords,
        'distance': route['distance'] / 1000, // km
        'duration': route['duration'], // seconds
      };
    } else {
      throw Exception('Failed to load route');
    }
  }

  String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    return hours > 0
        ? '$hours h ${minutes.toString().padLeft(2, '0')} min'
        : '$minutes min';
  }
}
