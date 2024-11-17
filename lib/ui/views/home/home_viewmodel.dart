import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeViewModel extends BaseViewModel {
  late GoogleMapController _mapController;
  LatLng _currentPosition = const LatLng(24.8607, 67.0011); 
  final Set<Marker> _markers = {};

  LatLng get currentPosition => _currentPosition;
  Set<Marker> get markers => _markers;


  Future<void> initializeLocation() async {
    setBusy(true);


    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
   
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      _currentPosition = LatLng(position.latitude, position.longitude);

   
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentPosition,
          infoWindow: InfoWindow(title: 'Your Current Location'),
        ),
      );

      
      if (_mapController != null) {
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition, 14.0),
        );
      }
    } else {
      print('Location permission denied');
    }

    setBusy(false);
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
   
    initializeLocation();
  }

  Future<void> searchPlace(String place) async {
    setBusy(true);
    try {
      const String apiKey = "f5f83ee9398a4fdcab06fceb2cc3cd7a"; 
      final String url = 'https://api.opencagedata.com/geocode/v1/json?q=$place&key=$apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results']?.isNotEmpty ?? false) {
          final result = data['results'][0];
          final location = result['geometry'];

          _currentPosition = LatLng(location['lat'], location['lng']);
          _markers.clear();
          _markers.add(
            Marker(
              markerId: const MarkerId('searched_location'),
              position: _currentPosition,
              infoWindow: InfoWindow(
                title: result['formatted_address'],
                snippet:
                    'Latitude: ${location['lat']}, Longitude: ${location['lng']}',
              ),
            ),
          );

          _mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_currentPosition, 14.0),
          );
        }
      } else {
        throw Exception('Failed to fetch place data');
      }
    } catch (e) {
      print('Error searching place: $e');
    }
    setBusy(false);
    notifyListeners();
  }
}
