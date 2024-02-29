import 'dart:convert';

class LocationValues {
  final double? latitude;
  final double? longitude;
  final double? speed;

  LocationValues({this.latitude, this.longitude, this.speed});

  factory LocationValues.fromJson(Map<String, dynamic> jsonData) {
    return LocationValues(
        latitude: jsonData['latitude'],
        longitude: jsonData['longitude'],
        speed: jsonData['speed']);
  }

  static Map<String, dynamic> toMap(LocationValues locationValues) => {
        'latitude': locationValues.latitude,
        'longitude': locationValues.longitude,
        'speed': locationValues.speed,
      };

  static String encode(List<LocationValues> locationValues) => json.encode(
        locationValues
            .map<Map<String, dynamic>>(
                (locationValue) => LocationValues.toMap(locationValue))
            .toList(),
      );

  static List<LocationValues> decode(String locationValues) =>
      (json.decode(locationValues) as List<dynamic>)
          .map<LocationValues>((item) => LocationValues.fromJson(item))
          .toList();
}
