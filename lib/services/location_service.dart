import 'package:geolocator/geolocator.dart';

class LocationData {
  final double latitude;
  final double longitude;
  final String? city;

  LocationData({
    required this.latitude,
    required this.longitude,
    this.city,
  });
}

class LocationService {
  // Default fallback location to Mumbai for MVP/graceful degradation
  final LocationData _defaultLocation = LocationData(
    latitude: 19.0760,
    longitude: 72.8777,
    city: 'Mumbai',
  );

  Future<bool> getPermissionStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
    }
    return permission != LocationPermission.deniedForever;
  }

  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return _defaultLocation;
    }

    bool hasPermission = await requestPermission();
    if (!hasPermission) {
      return _defaultLocation;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      
      // Note: Actual geocoding would use geocoding package. 
      // For MVP, returning mock city.
      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        city: 'Mumbai', 
      );
    } catch (e) {
      return _defaultLocation;
    }
  }
}
