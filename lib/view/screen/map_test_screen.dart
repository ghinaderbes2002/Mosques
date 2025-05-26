import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosques/controller/home_controller.dart';
import '../../core/services/location_service.dart';
import '../../core/services/search_service.dart';
import '../../core/services/route_service.dart';

class MapTestScreen extends StatefulWidget {
  const MapTestScreen({Key? key}) : super(key: key);



  @override
  State<MapTestScreen> createState() => _MapTestScreenState();
}

final Homecontrollerimp mosqueController = Get.put(Homecontrollerimp());


class _MapTestScreenState extends State<MapTestScreen> {
  static const String mapboxAccessToken =
      'pk.eyJ1IjoibW9ra3MiLCJhIjoiY20zdno3MXl1MHozNzJxcXp5bmdvbTllYyJ9.Ed_O6F-c2IZJE9DoCyPZ2Q';

  late GoogleMapController _mapController;
  late LocationService _locationService;
  late SearchService _searchService;
  late RouteService _routeService;

  LatLng? _currentLocation;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _locationService = LocationService();
    _searchService = SearchService(mapboxAccessToken: mapboxAccessToken);
    _routeService = RouteService(mapboxAccessToken: mapboxAccessToken);
    _initializeLocation();

    _loadMosques(); // استدعاء تحميل المساجد


  }

  Future<void> _loadMosques() async {
    await mosqueController.fetchMosque(); // استدعاء البيانات من API
    _addMosqueMarkers(); // بعدها أضفهم على الخريطة
  }

  void _addMosqueMarkers() {
    final mosques = mosqueController.mosquesList;

    setState(() {
      for (var mosque in mosques) {
        if (mosque.latitude != null && mosque.longitude != null) {
          _markers.add(Marker(
            markerId: MarkerId(mosque.mosqueId.toString()),
            position: LatLng(mosque.latitude!, mosque.longitude!),
            infoWindow: InfoWindow(title: mosque.nameMosque ?? "Mosque"),
          ));
        }

      }
    });
  }



  Future<void> _initializeLocation() async {
    final hasPermission = await _locationService.requestLocationPermission();
    if (!hasPermission) return;

    final position = await _locationService.getCurrentLocation();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _markers.add(Marker(
        markerId: const MarkerId('current_location'),
        position: _currentLocation!,
        infoWindow: const InfoWindow(title: 'Your Location'),
      ));
    });
    _moveCamera(_currentLocation!);
  }

  void _moveCamera(LatLng target) {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(target, 14));
  }

  Future<void> _searchPlace(String query) async {
    if (_currentLocation == null) return;

    final results = await _searchService.searchPlaces(query);
    if (results.isEmpty) return;

    final place = results.first;
    await _drawRouteTo(place.location, description: place.description);
  }

  Future<void> _drawRouteTo(LatLng destination, {String? description}) async {
    if (_currentLocation == null) return;

    final route = await _routeService.getRouteCoordinates(
      _currentLocation!,
      destination,
    );

    setState(() {
      _markers
        ..clear()
        ..add(Marker(
          markerId: const MarkerId('start'),
          position: _currentLocation!,
          infoWindow: const InfoWindow(title: 'Start'),
        ))
        ..add(Marker(
          markerId: const MarkerId('destination'),
          position: destination,
          infoWindow: InfoWindow(title: description ?? 'Destination'),
        ));

      _polylines = {
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          width: 5,
          points: route['polyline'],
        )
      };
    });

    _moveCamera(destination);
  }

  void _onLongPressMap(LatLng position) {
    _drawRouteTo(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Test')),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search place...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => _searchPlace(_searchController.text),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 14,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    onMapCreated: (controller) => _mapController = controller,
                    onLongPress: _onLongPressMap,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
              ],
            ),
    );
  }
}
